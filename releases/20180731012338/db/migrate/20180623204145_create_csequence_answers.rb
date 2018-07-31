class CreateCsequenceAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :csequence_answers do |t|
      t.references :csequence, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
