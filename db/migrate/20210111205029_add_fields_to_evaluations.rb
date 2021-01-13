class AddFieldsToEvaluations < ActiveRecord::Migration[5.1]
  def change
    add_reference :evaluations, :instrument, foreign_key: true
    add_reference :evaluations, :moment, foreign_key: true
    add_column :evaluations, :pass_assent, :boolean
    add_column :evaluations, :pass_instruction, :boolean
  end
end
