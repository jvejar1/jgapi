class EvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  require 'csv'
  def create

    render json:{request_id_to_delete:params[:request_id_to_delete],headers:{:status=>200}},:status=>:ok

    test_name=params[:test_name]
    responses=params[:responses]
    test_id=params[:test_id]
    evaluator_id=params[:evaluator_id]
    evaluator_id=nil unless evaluator_id!=0
    student_id=params[:student_id]
    timestamp=params[:timestamp]
    if ["aces","ace"].include?test_name
      ace=Ace.find(test_id)
      #ace_evaluation=AceEvaluation.create(user_id:evaluator_id,student_id:student_id,score:0)
      total_score=0

      ace_evaluation=AceEvaluation.create(ace:ace,student_id:student_id,user_id:evaluator_id)
      responses.each do |response|
        acase=Acase.find_by(id:response)
        correct_feelings=acase.acase_correct_feelings
        score=0
        correct_feelings.each do |correct_feeling|
          if correct_feeling.correct_feeling==responses[response]
            score+=1
          end
        end

        AcaseAnswer.create(acase_id:acase.id,ace_evaluation_id:ace_evaluation.id,score:score)

        total_score+=score
      end
      ace_evaluation.update(score:total_score)

    elsif test_name=="wally"
      wally=Wally.find_by(id:test_id)

      responses.each do |response|
        wsituation_id=response[:wsituation_id]
        wreaction=response[:wreaction]
        wfeeling=response[:wfeeling]
        wsituation=Wsituation.find_by(id:wsituation_id)

      end


    elsif test_name=="corsi"


    end


    def respond_with_success_to_erase(request_id_to_erase)
      render json:{request_id_to_delete:request_id_to_erase,headers:{:status=>201}},:status=>:accepted
      return
    end




  end




  def get_aces_csv
    current_ace=Ace.find_by(current:true)
    acases=current_ace.acases
    headers=["Rut","Nombres","Puntaje total"]
    column_index=1
    acases.each do |acase|
      headers<<"Aces "+column_index.to_s
      column_index+=1
    end
    evaluations=current_ace.ace_evaluations
    csv_string = CSV.generate do |csv|
      csv << headers
      evaluations.each do |evaluation|
        #get and puts student info
        row=[]
        student=evaluation.student
        row<<student.rut
        row<<student.last_name+" "+student.name
        row<<evaluation.score

        acases.each do |acase|
          answer=AcaseAnswer.find_by(acase:acase,ace_evaluation:evaluation)
          row<<answer.score if !answer.nil? else "N/A"
        end
        csv<<row
      end
      # ...
    end

    send_data csv_string, filename: "aces.csv"

  end


end
