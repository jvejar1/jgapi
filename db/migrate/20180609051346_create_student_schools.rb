class CreateStudentSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :student_schools do |t|
      t.references :student, foreign_key: true
      t.references :school, foreign_key: true
      t.references :school_level, foreign_key: true

      t.timestamps
    end
  end
end
