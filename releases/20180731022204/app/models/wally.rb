class Wally < ApplicationRecord
  has_many :wally_evaluations
  has_many :situation_sets
  has_many :wsituations, :through => :situation_sets

  has_many :evaluations

  def self.feelings_by_number
      return {1=>"FELIZ",2=>"TRISTE",3=>"ENOJADO",4=>"SOLO BIEN"}
  end

  def self.PROSOCIAL
    1
  end
  def self.AGRESIVA
    2
  end
  def self.DESREGULADA
    3
  end
  def self.EVASIVA
    4
  end
  end
