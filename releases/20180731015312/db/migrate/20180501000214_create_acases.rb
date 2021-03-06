class CreateAcases < ActiveRecord::Migration[5.1]
  def change
    create_table :acases do |t|
      t.timestamps
      t.string :sex, limit:1
      t.string :description
      t.integer :correct_feeling
      t.boolean :distractor
      t.references :picture, foreign_key:true
    end
  end
end
