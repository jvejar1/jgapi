class AddScoreToEvaluations < ActiveRecord::Migration[5.1]
  def change
    add_column :evaluations, :total_score, :integer
  end
end
