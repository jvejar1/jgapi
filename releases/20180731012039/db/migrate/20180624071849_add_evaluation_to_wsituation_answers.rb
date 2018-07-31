class AddEvaluationToWsituationAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :wsituation_answers, :evaluation, foreign_key: true
  end
end
