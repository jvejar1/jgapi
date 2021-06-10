class AddReportableIndexToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :reportable_index, :integer
  end
end
