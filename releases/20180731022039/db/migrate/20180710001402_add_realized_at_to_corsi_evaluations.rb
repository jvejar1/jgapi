class AddRealizedAtToCorsiEvaluations < ActiveRecord::Migration[5.1]
  def change
    add_column :corsi_evaluations, :realized_at, :datetime
  end
end
