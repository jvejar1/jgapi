class CreateEvaluationConstructScores < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluation_construct_scores do |t|
      t.references :evaluation, foreign_key: true
      t.references :construct, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
