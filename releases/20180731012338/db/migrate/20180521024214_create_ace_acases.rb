class CreateAceAcases < ActiveRecord::Migration[5.1]
  def change
    create_table :ace_acases do |t|
      t.references :ace, foreign_key: true
      t.references :acase, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
