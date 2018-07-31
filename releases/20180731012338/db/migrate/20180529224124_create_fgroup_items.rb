class CreateFgroupItems < ActiveRecord::Migration[5.1]
  def change
    create_table :fgroup_items do |t|
      t.references :item, foreign_key: true
      t.references :fgroup, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
