class CreateParticipantsFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :participants_files do |t|
      t.references :user, foreign_key: true
      t.integer :year

      t.timestamps
    end
  end
end
