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
  has_many :wsituation_answers
end
