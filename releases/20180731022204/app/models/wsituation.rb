class Wsituation < ApplicationRecord
  belongs_to :picture
  has_many :wreactions
  has_many :situation_sets
  has_many :wallies, through: :situation_sets
end
