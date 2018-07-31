class AddUserReferenceToCorsiEvaluations < ActiveRecord::Migration[5.1]
  def change
    add_reference :corsi_evaluations, :user, foreign_key: true
  end
end
