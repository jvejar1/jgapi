class CreateStudentNameChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :student_name_changes do |t|
      t.references :student, foreign_key: true
      t.string :old_name
      t.string :new_name
      t.string :old_last_name
      t.string :new_last_name

      t.timestamps
    end
  end
end
