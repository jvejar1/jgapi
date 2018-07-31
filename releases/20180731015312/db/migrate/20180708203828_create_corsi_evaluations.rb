class CreateCorsiEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :corsi_evaluations do |t|
      t.references :corsi, foreign_key: true
      t.references :student, foreign_key: true
      t.integer :ordered_score
      t.integer :reversed_score
      t.integer :ordered_practice_tries
      t.integer :reversed_practice_tries

      t.timestamps
    end
  end
end
