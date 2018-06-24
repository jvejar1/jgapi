class AddEvaluationToAcaseAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :acase_answers, :evaluation, foreign_key: true
  end
end
