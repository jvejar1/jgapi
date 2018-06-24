class CreateWsituationAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :wsituation_answers do |t|
      t.integer :wfeeling_answer
      t.integer :wreaction_answer
      t.references :wsituation, foreign_key: true

      t.timestamps
    end
  end
end
