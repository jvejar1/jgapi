class Csequence < ApplicationRecord
  has_many :corsi_csequences
  has_many :corsis, through: :corsi_csequences
  has_many :csquares
  default_scope { order(ordered: :desc) }
end
