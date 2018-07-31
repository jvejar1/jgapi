class AddSelectedFeelingToAcaseAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :acase_answers, :selected_feeling, :integer
  end
end
