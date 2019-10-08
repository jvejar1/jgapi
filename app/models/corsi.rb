class Corsi < ApplicationRecord
  has_many :corsi_csequences
  has_many :csequences, through: :corsi_csequences
  has_many :corsi_evaluations
  has_many :evaluations

  def get_evaluations
    self.corsi_evaluations
  end
end
