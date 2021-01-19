class CreateOpenAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :open_answers do |t|
      t.references :item, foreign_key: true
      t.references :evaluation, foreign_key: true
      t.text :answer_text
      t.integer :latency_seconds

      t.timestamps
    end
  end
end
