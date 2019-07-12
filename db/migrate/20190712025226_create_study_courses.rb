class CreateStudyCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :study_courses do |t|
      t.references :study, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
