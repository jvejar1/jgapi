class AddStudyToMoments < ActiveRecord::Migration[5.1]
  def change
    add_reference :moments, :study, foreign_key: true
  end
end
