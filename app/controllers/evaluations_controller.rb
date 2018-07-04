class EvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  require 'csv'

  #TODO: check the last edition of test to ignore certain old results
  #TODO: respond to erase

  def index
    @evaluations=Evaluation.all

  end

  def create

    render json:{request_id_to_delete:params[:request_id_to_delete],headers:{:status=>200}},:status=>:ok

    test_name=params[:test_name]
    responses=params[:responses]
    test_id=params[:test_id]
    evaluator_id=params[:evaluator_id]
    evaluator_id=nil unless evaluator_id!=0
    student_id=params[:student_id]
    realized_at=params[:timestamp].to_datetime
    if ["aces","ace"].include?test_name
      ace=Ace.find(test_id)
      #ace_evaluation=AceEvaluation.create(user_id:evaluator_id,student_id:student_id,score:0)
      total_score=0

      old_eval=Evaluation.where(ace_id:ace.id,student_id:student_id,realized_at:realized_at).first
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return
      end

      ace_evaluation=Evaluation.create(ace:ace,student_id:student_id,user_id:evaluator_id,realized_at:realized_at)
      responses.each do |response|
        acase=Acase.find_by(id:response)
        correct_feelings=acase.acase_correct_feelings
        score=0
        if(!acase.distractor?)
          correct_feelings.each do |correct_feeling|
            if correct_feeling.correct_feeling==responses[response]
              score+=1
            end
          end
        end

        AcaseAnswer.create(acase_id:acase.id,evaluation_id:ace_evaluation.id,score:score,selected_feeling:responses[response])

        total_score+=score
      end
      ace_evaluation.update(total_score:total_score)


    elsif test_name=="wally"

      wally=Wally.find_by(id:test_id)
      old_eval=Evaluation.where(wally_id:wally.id,student_id:student_id,realized_at:realized_at).first
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return
      end

      wally_evaluation=Evaluation.create(student_id:student_id,user_id:evaluator_id,realized_at:realized_at,wally_id:wally.id)
      responses.each do |response|
        wsituation_id=response[:wsituation_id]
        wreaction=response[:wreaction]
        wfeeling=response[:wfeeling]
        wsituation=Wsituation.find_by(id:wsituation_id)
        WsituationAnswer.create(evaluation_id:wally_evaluation.id,wfeeling_answer:wfeeling,wreaction_answer:wreaction,wsituation_id:wsituation.id)

      end


    elsif test_name=="corsi"

      corsi=Corsi.find_by(id:test_id)


      #check if record exists
      old_eval=Evaluation.where(corsi_id:corsi.id,student_id:student_id,realized_at:realized_at).first
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return
      end
      csequences=corsi.csequences
      #in this case the response is a list of hashes, each element contains
      # the key csequence_id,score, TODO: change it in android to do it a unique hash whit a value that contains the time
      ordered_score=params[:ordered_score]
      reversed_score=params[:reversed_score]
      evaluation=Evaluation.create(corsi_id:corsi.id,user_id:evaluator_id,student_id:student_id,realized_at:realized_at)
      total_score=0
      responses.each do |response|
        csequence_id=response[:csequence_id]
        score=response[:score]
        CsequenceAnswer.create(csequence_id:csequence_id,score:score,evaluation_id:evaluation.id)
        total_score+=score
      end
      evaluation.update(total_score:total_score)


    elsif test_name=="fonotest"

      scores=params[:scores].split(',')

      scores.each do |score|
        puts scores.class
        puts scores.respond_to?(:each_pair)
        puts scores.respond_to?(:has_key?)
        puts scores.respond_to?(:to_hash)

      end
      puts scores.kind_of?(Hash)

    elsif test_name=="hnf"
      old_evaluation=Evaluation.find_by(hnfset_id:test_id,realized_at:realized_at)
      if !old_evaluation.nil?
        puts "EVALUATION ALREADY EXISTS"
        return
      end
      hnfset=Hnfset.find_by(id:test_id)

      hearts_score=params[:hearts_score]
      flowers_score=params[:flowers_score]
      hnf_score=params[:hnf_score]

      total_score=hearts_score+flowers_score+hnf_score
      hnf_evaluation=Evaluation.create(realized_at:realized_at,hnfset_id:hnfset.id,user_id:evaluator_id,student_id:student_id,total_score:total_score)

      hnftests=hnfset.hnftests
      hnftests.each do |test|
        if test.hnf_type==Hnftest.HEARTS_TEST_TYPE


          HnfAnswer.create(evaluation_id:hnf_evaluation.id,hnftest_id:test.id,score:hearts_score)

        elsif test.hnf_type==Hnftest.FLOWERS_TEST_TYPE

          HnfAnswer.create(evaluation_id:hnf_evaluation.id,hnftest_id:test.id,score:flowers_score)

        else

          HnfAnswer.create(evaluation_id:hnf_evaluation.id,hnftest_id:test.id,score:hnf_score)
        end

      end

    end


    def respond_with_success_to_erase(request_id_to_erase)
      render json:{request_id_to_delete:request_id_to_erase,headers:{:status=>201}},:status=>:accepted
      return
    end




  end


  def get_hnf_csv
    hnfset=Hnfset.find_by(current:true)
    evaluations=hnfset.evaluations
    headers=["Rut","Nombres","Puntaje total"]



    puts "hola"
    hnftests=hnfset.hnftests


    hnftests.each do |test|
      headers<<"Puntaje "+Hnftest.TEST_NAME_BY_NUMBER[test.hnf_type]
    end
    puts headers

    csv_string=CSV.generate do |csv|

      csv<<headers


      evaluations.each do |eval|
        row=[]

        student=eval.student
        row<<student.rut
        row<<student.last_name+" "+student.name
        row<<eval.total_score
        hnf_answers=eval.hnf_answers
        hnftests.each do |hnftest|
          hnf_answer=hnf_answers.find_by(hnftest_id:hnftest.id)
          row<<hnf_answer.score

        end
        csv<<row
      end

    end
    send_data csv_string, filename: "hnf.csv"
  end


  def get_aces_csv
    current_ace=Ace.find_by(current:true)
    acases=current_ace.acases
    headers=["Rut","Nombres","Puntaje total"]
    column_index=1
    acases.each do |acase|
      headers<<"Aces "+column_index.to_s
      headers<<"Respuesta Aces "+column_index.to_s
      column_index+=1
    end
    evaluations=current_ace.evaluations
    csv_string = CSV.generate do |csv|
      csv << headers
      evaluations.each do |evaluation|
        #get and puts student info
        row=[]
        student=evaluation.student
        row<<student.rut
        row<<student.last_name+" "+student.name
        row<<evaluation.total_score

        acases.each do |acase|
          answer=AcaseAnswer.find_by(acase:acase,evaluation:evaluation)
          if !answer.nil?
            row<<answer.score
          else
            row<<"N/A"
          end

          row<<answer.selected_feeling
        end
        csv<<row
      end
      # ...
    end

    send_data csv_string, filename: "aces.csv"

  end



  def get_wally_csv
    wally=Wally.find_by(current:true)
    wally_evaluations=wally.evaluations
    headers=["Rut","Nombre"]
    wsituations=wally.wsituations

    #generate headers for each wsituation
    counter=1
    wsituations.each do |wsituation|
      headers<<"Wally emocion "+counter.to_s
      headers<<"Wally comportamiento "+counter.to_s
      counter+=1
    end
    csv_string=CSV.generate do |csv|
      csv<<headers
      wally_evaluations.each do |wally_evaluation|
        row=[]
        answers=wally_evaluation.wsituation_answers
        student=wally_evaluation.student
        row<<student.rut
        row<<student.last_name+" "+student.name


        wsituations.each do |wsituation|
          wsituation_answer=answers.find_by(evaluation_id:wally_evaluation.id,wsituation_id:wsituation.id)
          feeling_answer,reaction_answer="N/A","N/A"
          if !wsituation_answer.nil?
            feeling_answer,reaction_answer=wsituation_answer.wfeeling_answer,wsituation_answer.wreaction_answer
          end
          row<<feeling_answer
          row<<reaction_answer
        end


      csv<<row
      end
    end

    send_data csv_string, filename: "wally.csv"


  end

  def get_corsi_csv
    corsi=Corsi.find_by(current:true)
    corsi_evaluations=corsi.evaluations

    csequences=corsi.csequences

    headers=["Rut","Nombres","Puntaje total"]

    #define the header for each cseq

    counter=1
    csequences.each do |cseq|
      header="Corsi "+counter.to_s
      if cseq.ordered?
        header+=" (Ordenado)"
      else

        header+=" (Contrario)"
      end
      headers<<header
      counter+=1
    end

    csv_string=CSV.generate do |csv|
      csv<<headers

      corsi_evaluations.each do |eval|

        #get student_info
        cseq_answers=eval.csequence_answers
        puts cseq_answers.as_json
        puts "hola"
        row=[]
        student=eval.student
        row<<student.rut
        row<<student.last_name+" "+student.name
        row<<eval.total_score
        csequences.each do |cseq|
          cseq_answer=cseq_answers.find_by(csequence_id:cseq.id)
          if cseq_answer.nil?
            row<<"N/A"
          else
            row<<cseq_answer.score

          end

        end
        csv<<row

      end
    end
    puts csv_string
    send_data csv_string, filename: "corsi.csv"



  end

  def respond_with_not_accepted_status(request_id_to_delete)
    render json:{request_id_to_delete:request_id_to_delete,headers:{:status=>202}},:status=>:not_acceptable
  end

end
