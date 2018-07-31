class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.references :commune,foreign_key:true
      t.string :street
      t.string :street_number
      t.string :phone_number

      t.timestamps
    end
  end
end
