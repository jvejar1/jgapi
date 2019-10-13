class CorsiEvaluation < ApplicationRecord
  belongs_to :corsi
  belongs_to :student
  belongs_to :user
  has_many :csequence_answers

  def self.get_headers(index)
    index = index.to_s
    return ['course_'+index, 'evaluator_'+index,'application_date_'+index,'server_date_'+index]

  end

  def self.get_info(evaluation)
    if evaluation.nil?
      return ['', '', '']
    else
      return [evaluation.user.email,evaluation.realized_at, evaluation.created_at]
    end
  end
end
