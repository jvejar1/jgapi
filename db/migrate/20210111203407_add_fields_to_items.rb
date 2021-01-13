class AddFieldsToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :instrument, foreign_key: true
    add_column :items, :title, :string
    add_column :items, :order, :integer
    add_reference :items, :picture, foreign_key: true
    add_column :items, :is_for_practice, :boolean
    add_column :items, :item_type, :int
  end
end
