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

      old_eval=Evaluation.find_by(ace_id:ace.id,student_id:student_id,realized_at:realized_at)
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return
      end

      ace_evaluation=Evaluation.create(ace:ace,student_id:student_id,user_id:evaluator_id,realized_at:realized_at)
      if ace_evaluation.errors.any?
        puts ace_evaluation.errors.as_json
      end
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

        acase_answer=AcaseAnswer.create(acase_id:acase.id,evaluation_id:ace_evaluation.id,score:score,selected_feeling:responses[response])
        if acase_answer.errors.any?
          puts acase_answer.errors.as_json
        end
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
      old_eval=CorsiEvaluation.where(corsi_id:corsi.id,student_id:student_id,realized_at:realized_at).first
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return
      end
      csequences=corsi.csequences
      #in this case the response is a list of hashes, each element contains
      # the key csequence_id,score, TODO: change it in android to do it a unique hash whit a value that contains the time
      ordered_score=params[:ordered_score]
      reversed_score=params[:reversed_score]
      ordered_practice_tries=params[:ordered_practice_tries]
      reversed_practice_tries=params[:reversed_practice_tries]
      evaluation=CorsiEvaluation.create(corsi_id:corsi.id,ordered_practice_tries:ordered_practice_tries,reversed_practice_tries:reversed_practice_tries,ordered_score:ordered_score,reversed_score:reversed_score,user_id:evaluator_id,student_id:student_id,realized_at:realized_at)
      total_score=0
      responses.each do |response|
        csequence_id=response[:csequence_id]
        score=response[:score]

        answer_time=response[:response_time]
        answer_string=response[:response_string]

        join_record_corsi_cseq=CorsiCsequence.find_by(corsi_id:corsi.id,csequence_id:csequence_id)

        if(join_record_corsi_cseq.example)
          score=0
        end

        CsequenceAnswer.create(csequence_id:csequence_id,score:score,time_in_seconds:answer_time,corsi_evaluation_id:evaluation.id,answer_string:answer_string)

        total_score+=score
      end

    elsif test_name=="fonotest"

      test=Fonotest.find_by(id:params[:test_id])

      #TODO: check if the eval already exists
      old_eval=Evaluation.find_by(fonotest_id:test.id,student_id:student_id,realized_at:realized_at)
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return
      end
      responses=params[:responses]
      scores=params[:scores]
      test_items=test.items
      eval=Evaluation.create(fonotest_id:test.id,user_id:evaluator_id,student_id:student_id,realized_at:realized_at)

      total_score=0
      test_items.each do |test_item|

        item_score=scores[test_item.id.to_s]
        item_answer_string=responses[test_item.id.to_s]

        if item_score.nil? or item_answer_string.nil?
          next
        end

        total_score+=item_score
        ItemAnswer.create(item_id:test_item.id,evaluation_id:eval.id,score:item_score,answer_string:item_answer_string)
      end

    elsif test_name=="hnf"
      old_evaluation=Evaluation.find_by(hnfset_id:test_id,realized_at:realized_at)
      if !old_evaluation.nil?
        puts "EVALUATION ALREADY EXISTS"
        return
      end
      hnfset=Hnfset.find_by(id:test_id)
      results_array=params[:results_array]
      hnf_evaluation=Evaluation.create(realized_at:realized_at,hnfset_id:hnfset.id,user_id:evaluator_id,student_id:student_id)
      hnftests=hnfset.hnftests
      total_score=0

      results_array.each do |result_json|
        test=Hnftest.find_by(id:result_json[:test_id])
        score=result_json[:score]
        total_errors=result_json[:errors]
        omitted=result_json[:omitted]
        delta_time=result_json[:delta_time]
        HnfAnswer.create(evaluation_id:hnf_evaluation.id,hnftest_id:test.id,score:score,total_errors:total_errors,omitted:omitted,time_in_seconds:delta_time)
        total_score+=score

      end

      Evaluation.update(total_score:total_score)
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
      headers<<"Tiempo en segundos "+ Hnftest.TEST_NAME_BY_NUMBER[test.hnf_type]
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

          row<<hnf_answer.time_in_seconds
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

            row<<answer.selected_feeling
          else
            row<<"N/A"
            row<<"N/A"
          end

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


        row<<wally_evaluation.realized_at
      csv<<row
      end
    end

    send_data csv_string, filename: "wally.csv"


  end

  def get_corsi_csv
    corsi=Corsi.find_by(current:true)
    corsi_evaluations=corsi.corsi_evaluations

    csequences=corsi.csequences

    headers=["Rut","Nombres","Puntaje total"," Ensayos Ordenado","   Ensayos Contrario"]

    #define the header for each cseq

    counter=1
    csequences.each do |cseq|

      join_corsi_cseq_record=CorsiCsequence.find_by(csequence_id:cseq.id,corsi_id:corsi.id)
      if(join_corsi_cseq_record.example)
        header="Ejemplo Corsi "+join_corsi_cseq_record.index.to_s
      else
        header="Corsi "+counter.to_s
        counter+=1

      end
      if cseq.ordered?
        header+=" (Ordenado)"
      else

        header+=" (Contrario)"
      end
      headers<<header
      headers<<"Respuesta"
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
        row<<eval.reversed_score+eval.ordered_score
        row<<eval.ordered_practice_tries
        row<<eval.reversed_practice_tries

        csequences.each do |cseq|
          cseq_answer=cseq_answers.find_by(csequence_id:cseq.id)
          if cseq_answer.nil?
            row<<"N/A"
            row<<"N/A"
          else
            row<<cseq_answer.score
            row<<cseq_answer.answer_string
          end

        end
        csv<<row

      end
    end
    puts csv_string
    send_data csv_string, filename: "corsi.csv"



  end

  def get_fonotest_csv
    fonotest=Fonotest.find_by(current:true)
    fonotest_item_joins=fonotest.fonotest_items
    evaluations=fonotest.evaluations
    headers=["Rut","Nombre"]
    fonotest_item_joins.each do |fonotest_item_join|
      header_name=fonotest_item_join.name
      headers<<header_name+" Puntaje"
      headers<<header_name+" Respuesta"
    end



    csv_string=CSV.generate do |csv|
      csv<<headers
      evaluations.each do |eval|
        row=[]
        student=eval.student
        row<<student.rut
        row<<student.last_name+" "+student.name
        fonotest_item_joins.each do |fonotest_item_join|
          item_answer=ItemAnswer.find_by(item_id:fonotest_item_join.item_id,evaluation_id:eval.id)
          if(item_answer.nil?)
            row.push("N/A")
            row.push("N/A")
          else
            row<<item_answer.score

            row<<item_answer.answer_string
          end
        end
        puts row.to_s
      csv<<row
      end

    end
    send_data csv_string, filename: "test_fonologico.csv"

  end

  def respond_with_not_accepted_status(request_id_to_delete)
    render json:{request_id_to_delete:request_id_to_delete,headers:{:status=>202}},:status=>:not_acceptable
  end

end
