class StudentCourse < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates :entry, :student, :course, presence: true

  validates :student, uniqueness: { scope: [:course,:entry],
                                 message: "should happen once per year" }
end
