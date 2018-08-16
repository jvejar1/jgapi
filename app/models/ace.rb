class Ace < ApplicationRecord
  has_many :ace_acases
  has_many :acases,through: :ace_acases
  has_many :ace_evaluations
  has_many :evaluations
  def self.ANGRY
    1
  end
  def self.HAPPY
    2
  end
  def self.SAD
    3
  end

  def self.SCARED
    4
  end

end
