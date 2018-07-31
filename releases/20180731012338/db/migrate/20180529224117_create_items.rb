class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :audio, foreign_key: true
      t.string :description
      t.string :correct_sequence
      t.timestamps
    end
  end
end
