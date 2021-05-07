class ParticipantsFile < ApplicationRecord
  belongs_to :user
  has_many :schools
  accepts_nested_attributes_for :schools, reject_if:proc{|attributes| attributes['name'].blank?}
end
