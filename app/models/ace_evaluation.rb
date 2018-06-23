class AceEvaluation < ApplicationRecord
  belongs_to :ace
  belongs_to :user
  belongs_to :student
  has_many :acase_answers
end
