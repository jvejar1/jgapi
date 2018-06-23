class CreateAceEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :ace_evaluations do |t|
      t.references :ace, foreign_key: true
      t.references :user, foreign_key: true
      t.references :student, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
