class Corsi < ApplicationRecord
  has_many :corsi_csequences
  has_many :csequences, through: :corsi_csequences
end
