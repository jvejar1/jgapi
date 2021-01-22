class CreateChoiceAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :choice_answers do |t|
      t.references :evaluation, foreign_key: true
      t.references :choice, foreign_key: true
      t.integer :selection_order
      t.integer :latency_seconds

      t.timestamps
    end
  end
end
