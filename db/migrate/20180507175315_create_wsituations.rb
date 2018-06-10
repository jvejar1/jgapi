class CreateWsituations < ActiveRecord::Migration[5.1]
  def change
    create_table :wsituations do |t|
      t.references :picture, foreign_key: true
      t.string :description
      t.timestamps
    end
  end
end
