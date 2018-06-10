class CreateWreactions < ActiveRecord::Migration[5.1]
  def change
    create_table :wreactions do |t|
      t.string :description
      t.integer :wreaction
      t.references :picture, foreign_key:true
      t.references :wsituation, foreign_key:true
      t.timestamps
    end
  end
end
