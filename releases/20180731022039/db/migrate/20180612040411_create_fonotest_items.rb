class CreateFonotestItems < ActiveRecord::Migration[5.1]
  def change
    create_table :fonotest_items do |t|
      t.references :fonotest, foreign_key: true
      t.references :item, foreign_key: true
      t.string :name
      t.boolean :example
      t.integer :index

      t.string :instruction
      t.timestamps
    end
  end
end
