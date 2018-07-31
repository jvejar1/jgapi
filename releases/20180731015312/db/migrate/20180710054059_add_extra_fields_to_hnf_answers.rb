class AddExtraFieldsToHnfAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :hnf_answers, :time_in_seconds, :float
    add_column :hnf_answers, :corrects, :integer
    add_column :hnf_answers, :omitted, :integer
    add_column :hnf_answers, :total_errors, :integer
    add_column :hnf_answers, :practice_tries, :integer
  end
end
