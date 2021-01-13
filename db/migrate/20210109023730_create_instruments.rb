class CreateInstruments < ActiveRecord::Migration[5.1]
  def change
    create_table :instruments do |t|
      t.string :name
      t.string :instruction
      t.references :personalisation_of_instrument, foreign_key: {to_table: :instruments}
      t.integer :for_sex

      t.timestamps
    end
  end
end
