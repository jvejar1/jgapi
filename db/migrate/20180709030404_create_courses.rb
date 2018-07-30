class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :level
      t.integer :letter
      t.references :school, foreign_key: true
      t.timestamps
    end
  end
end
