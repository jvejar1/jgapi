class ChangeChoicesIsRightForIsCorrect < ActiveRecord::Migration[5.1]
  def change
    rename_column :choices, :is_right, :is_correct
  end
end
