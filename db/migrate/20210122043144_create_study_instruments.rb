class CreateStudyInstruments < ActiveRecord::Migration[5.1]
  def change
    create_table :study_instruments do |t|
      t.references :study, foreign_key: true
      t.references :instrument, foreign_key: true

      t.timestamps
    end
  end
end
