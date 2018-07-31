class CreateHnfAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :hnf_answers do |t|
      t.references :evaluation, foreign_key: true
      t.references :hnftest, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
