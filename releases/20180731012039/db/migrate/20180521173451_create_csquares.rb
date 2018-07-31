class CreateCsquares < ActiveRecord::Migration[5.1]
  def change
    create_table :csquares do |t|
      t.integer :square
      t.references :csequence, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
