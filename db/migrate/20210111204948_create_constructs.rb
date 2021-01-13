class CreateConstructs < ActiveRecord::Migration[5.1]
  def change
    create_table :constructs do |t|
      t.string :name
      t.references :calculation_type, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
    end
  end
end
