class AddYearToStudies < ActiveRecord::Migration[5.1]
  def change
    add_column :studies, :year, :integer
  end
end
