class AddYearToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :year, :integer
  end
end
