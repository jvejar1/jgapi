class CreateWfeelings < ActiveRecord::Migration[5.1]
  def change
    create_table :wfeelings do |t|
      t.references :picture, foreign_key: true
      t.integer :wfeeling
      t.timestamps
    end
  end
end
