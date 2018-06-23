class CreateAcaseAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :acase_answers do |t|
      t.references :ace_evaluation, foreign_key: true
      t.references :acase, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
