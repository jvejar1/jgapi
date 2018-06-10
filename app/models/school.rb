class School < ApplicationRecord
  has_many :student_schools, dependent: :destroy
  has_many :students, through: :student_schools
end
