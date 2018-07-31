class CreateCorsiCsequences < ActiveRecord::Migration[5.1]
  def change
    create_table :corsi_csequences do |t|
      t.references :corsi, foreign_key: true
      t.references :csequence, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
