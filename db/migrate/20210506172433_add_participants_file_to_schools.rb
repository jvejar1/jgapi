class AddParticipantsFileToSchools < ActiveRecord::Migration[5.1]
  def change
    add_reference :schools, :participants_file, foreign_key: true
  end
end
