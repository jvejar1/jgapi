class CorsiEvaluation < ApplicationRecord
  belongs_to :corsi
  belongs_to :student
  has_many :csequence_answers
end
