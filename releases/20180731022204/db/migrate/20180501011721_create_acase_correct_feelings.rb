class CreateAcaseCorrectFeelings < ActiveRecord::Migration[5.1]
  def change
    create_table :acase_correct_feelings do |t|
      t.references :acase, foreign_key: true
      t.integer :correct_feeling
      t.timestamps
    end
  end
end
