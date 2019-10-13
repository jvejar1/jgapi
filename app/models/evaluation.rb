class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :student
  belongs_to :wally
  belongs_to :corsi
  belongs_to :fonotest
  belongs_to :hnfset
  belongs_to :ace
  has_many :csequence_answers
  has_many :hnf_answers
  has_many :wsituation_answers, dependent: :destroy
  has_many :acase_answers, dependent: :destroy
  has_many :item_answers, dependent: :destroy


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
