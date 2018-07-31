class CreateItemAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :item_answers do |t|
      t.references :evaluation, foreign_key: true
      t.references :item, foreign_key: true
      t.string :answer_string
      t.integer :score

      t.timestamps
    end
  end
end
