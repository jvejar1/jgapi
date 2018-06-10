class Wally < ApplicationRecord
  def self.feelings_by_number
      return {1=>"ENOJADO",2=>"SOLO BIEN",3=>"FELIZ",4=>"TRISTE"}
  end
  has_many :situation_sets
  has_many :wsituations, :through => :situation_sets
end
