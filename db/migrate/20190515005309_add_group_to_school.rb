class AddGroupToSchool < ActiveRecord::Migration[5.1]
  def change
    add_column :schools, :group, :integer
  end
end
