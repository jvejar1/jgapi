class StudentCourse < ApplicationRecord
  belongs_to :student
  accepts_nested_attributes_for :student, reject_if: proc {|attributes| attributes['name'].blank? and attributes['last_name'].blank?}
  belongs_to :course


  validates :student, uniqueness: { scope: [:course,:entry],
                                 message: "should happen once per year" }
end
