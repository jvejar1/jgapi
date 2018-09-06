class CorsiEvaluation < ApplicationRecord
  belongs_to :corsi
  belongs_to :student
  belongs_to :user
  has_many :csequence_answers
end
