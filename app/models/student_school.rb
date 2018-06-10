class StudentSchool < ApplicationRecord
  belongs_to :student
  belongs_to :school
  belongs_to :school_level
end
