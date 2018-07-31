class AddTimeToCsequenceAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :csequence_answers, :time_in_seconds, :float
  end
end
