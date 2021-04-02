class ChangeCourseEnrollmentDateToDateTime < ActiveRecord::Migration[5.1]
  def change
      change_column(:student_courses, :entry, :datetime)
  end
end
