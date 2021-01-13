class CangeItemTypeInItems < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :item_type, :item_type_id
    add_foreign_key :items, :item_types

  end
end
