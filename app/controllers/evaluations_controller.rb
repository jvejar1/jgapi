class EvaluationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  require "#{Rails.root}/lib/hash_converter"
  include HashConverter
  skip_before_action :authenticate_user!, only: :create
  before_action :authenticate_token, only: :create
  require 'csv'

  #TODO: check the last edition of test to ignore certain old results
  #TODO: respond to erase
  require 'json'
  def create

    evaluation_json = params[:evaluation]
    if evaluation_json.is_a? String
      evaluation_json = JSON.parse(evaluation_json)
      evaluation = Evaluation.new instrument_id: evaluation_json["instrumentId"], user_id: evaluation_json["userId"], student_id: evaluation_json["studentId"], realized_at: evaluation_json["timestamp"]
      evaluation.save
      _answers = evaluation_json["itemAnswerList"]
      _answers.each do |answer|
        open_answer = OpenAnswer.new(item_id: answer["itemId"], answer_text: answer["answer"], latency_seconds: answer["latencySeconds"], evaluation_id: evaluation.id)
        open_answer.save
      end
      render json:{request_id_to_delete:params[:request_id_to_delete],headers:{:status=>200}},:status=>:ok
      return
    end


    test_name=params[:test_name]
    responses=params[:responses]
    test_id=params[:test_id]
    evaluator_id=@current_user.id
    student_id=params[:student_id]
    request_id_to_delete = params[:request_id_to_delete] #request id in the android device to delete after create the evaluation resource
    realized_at=params[:timestamp].to_datetime
    if ["aces","ace"].include?test_name
      ace=Ace.find(test_id)
      #ace_evaluation=AceEvaluation.create(user_id:evaluator_id,student_id:student_id,score:0)

      old_eval=Evaluation.find_by(ace_id:ace.id,student_id:student_id,realized_at:realized_at)
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return respond_created_evaluation(request_id_to_delete)
      end

      total_score=0

      ace_evaluation=Evaluation.create(ace:ace,student_id:student_id,user_id:evaluator_id,realized_at:realized_at)
      if ace_evaluation.errors.any?
        puts ace_evaluation.errors.as_json
      end


      responses.each do |response|
        acase=Acase.find_by(id:response)

        score=0

        puts acase.correct_feeling,responses[response]
        if acase.correct_feeling==responses[response]
          score=1
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
        return respond_created_evaluation(request_id_to_delete)
      end

      wally_evaluation=Evaluation.create(student_id:student_id,user_id:evaluator_id,realized_at:realized_at,wally_id:wally.id)
      responses.each do |response|

        wsituation_id=response

        douple_hash=responses[response]
        wreaction=douple_hash[:wreaction]
        wfeeling=douple_hash[:wfeeling]
        wsituation=Wsituation.find_by(id:wsituation_id)
        WsituationAnswer.create(evaluation_id:wally_evaluation.id,wfeeling_answer:wfeeling,wreaction_answer:wreaction,wsituation_id:wsituation.id)

      end


    elsif test_name=="corsi"

      corsi=Corsi.find_by(id:test_id)


      #check if record exists
      old_eval=CorsiEvaluation.where(corsi_id:corsi.id,student_id:student_id,realized_at:realized_at).first
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return respond_created_evaluation(request_id_to_delete)
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

        if(!join_record_corsi_cseq.example)
          total_score+=score
        end

        CsequenceAnswer.create(csequence_id:csequence_id,score:score,time_in_seconds:answer_time,corsi_evaluation_id:evaluation.id,answer_string:answer_string)
      end

    elsif test_name=="fonotest"

      test=Fonotest.find_by(id:params[:test_id])

      #TODO: check if the eval already exists
      old_eval=Evaluation.find_by(fonotest_id:test.id,student_id:student_id,realized_at:realized_at)
      if !old_eval.nil?
        puts "SKIPPING BECAUSE THE EVALUATION ALREADY EXISTS"
        return respond_created_evaluation(request_id_to_delete)
      end
      responses=params[:responses]
      scores=params[:scores]
      test_items=test.items
      eval=Evaluation.create(fonotest_id:test.id,user_id:evaluator_id,student_id:student_id,realized_at:realized_at)

      total_score=0
      test_items.each do |test_item|

        join_fonotest_item=test.fonotest_items.find_by(item_id:test_item)

        item_score=scores[test_item.id.to_s]
        item_answer_string=responses[test_item.id.to_s]

        if item_score.nil? or item_answer_string.nil?
          next
        end

        if(!join_fonotest_item.example)
          total_score+=item_score
        end
        ItemAnswer.create(item_id:test_item.id,evaluation_id:eval.id,score:item_score,answer_string:item_answer_string)
      end
      eval.update(total_score:total_score)


    elsif test_name=="hnf"
      old_evaluation=Evaluation.find_by(hnfset_id:test_id,realized_at:realized_at)
      if !old_evaluation.nil?
        puts "EVALUATION ALREADY EXISTS"
        return respond_created_evaluation(request_id_to_delete)
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

      hnf_evaluation.update(total_score:total_score)

    else



      params[:student_id]

      evaluation = Evaluation.new
      json =  JSON.parse(params.to_hash)
      puts json
      evaluation.student
      puts responses
      render {}
      end


    render json:{request_id_to_delete:params[:request_id_to_delete],headers:{:status=>200}},:status=>:ok





  end

  def respond_created_evaluation(request_id_to_erase)
    puts "HOLA"
    render json:{request_id_to_delete:request_id_to_erase,headers:{:status=>201}},:status=>:created
    return
  end

  def respond_with_not_accepted_status(request_id_to_delete)
    render json:{request_id_to_delete:request_id_to_delete,headers:{:status=>202}},:status=>:not_acceptable
  end

end
