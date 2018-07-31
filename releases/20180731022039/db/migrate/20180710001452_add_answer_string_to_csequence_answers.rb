class AddAnswerStringToCsequenceAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :csequence_answers, :answer_string, :string
  end
end
