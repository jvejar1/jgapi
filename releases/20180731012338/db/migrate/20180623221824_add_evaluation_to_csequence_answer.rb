class AddEvaluationToCsequenceAnswer < ActiveRecord::Migration[5.1]
  def change
    add_reference :csequence_answers, :evaluation, foreign_key: true
  end
end
