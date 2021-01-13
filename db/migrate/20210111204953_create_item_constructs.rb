class CreateItemConstructs < ActiveRecord::Migration[5.1]
  def change
    create_table :item_constructs do |t|
      t.references :item, foreign_key: true
      t.references :construct, foreign_key: true

      t.timestamps
    end
  end
end
