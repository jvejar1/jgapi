class School < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :students, through: :courses
  default_scope { order(name: :asc) }

  #@@groups ={CONTROL => 'control', INTERVENCION => 'intervencion' }
  CONTROL = 0
  INTERVENTION = 1

  def self.groups
    {CONTROL => 'control', INTERVENTION => 'intervencion'}
  end






end
