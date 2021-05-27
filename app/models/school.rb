class School < ApplicationRecord
  has_many :courses, dependent: :destroy
  accepts_nested_attributes_for :courses, reject_if: proc{|attributes| attributes['name'].blank?}
  has_many :students, through: :courses
  default_scope { order(name: :asc) }
  belongs_to :participants_file

  #@@groups ={CONTROL => 'control', INTERVENCION => 'intervencion' }
  CONTROL = 0
  INTERVENTION = 1

  def self.groups
    {CONTROL => 'control', INTERVENTION => 'intervencion'}
  end







end
