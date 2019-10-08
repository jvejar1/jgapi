class Wally < ApplicationRecord
  has_many :wally_evaluations
  has_many :situation_sets
  has_many :wsituations, :through => :situation_sets
  has_many :evaluations

  def self.feelings_by_number
      return {1=>"FELIZ",2=>"TRISTE",3=>"ENOJADO",4=>"SOLO BIEN"}
  end

  def self.HAPPY
    1
  end
  def self.SAD
    2
  end
  def self.ANGRY
    3
  end
  def self.ONLY_GOOD
    4
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
  def self.get_info_rows
   rows=[["Sentimiento"+ self.HAPPY.to_s,"FELIZ","",""+ self.PROSOCIAL.to_s,"PROSOCIAL"],
         ["Sentimiento"+ self.SAD.to_s,"TRISTE","",""+ self.AGRESIVA.to_s,"AGRESIVO"],
         ["Sentimiento"+ self.ANGRY.to_s,"ENOJADO","",""+ self.DESREGULADA.to_s,"DESREGULADA"],
         ["Sentimiento"+ self.ONLY_GOOD.to_s,"SOLO BIEN","",""+ self.EVASIVA.to_s,"EVASIVA"]]
  end

  def get_evaluations
    self.evaluations
  end
  end
