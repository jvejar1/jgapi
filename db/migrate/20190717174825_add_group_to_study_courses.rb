class AddGroupToStudyCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :study_courses, :group, :integer
  end
end
