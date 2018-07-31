class AddCorsiEvaluationReferenceToCsequenceAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :csequence_answers, :corsi_evaluation, foreign_key: true
  end
end
