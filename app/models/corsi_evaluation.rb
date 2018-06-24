class CorsiEvaluation < ApplicationRecord
  belongs_to :student
  belongs_to :user
  belongs_to :corsi

end
