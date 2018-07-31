class CreateWallies < ActiveRecord::Migration[5.1]
  def change
    create_table :wallies do |t|
      t.decimal :version
      t.text :description
      t.boolean :current
      t.timestamps
    end
  end
end
