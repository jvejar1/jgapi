class AddScoreToChoiceAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :choice_answers, :score, :integer, {default: 0}
  end
end
