class CreateFgroups < ActiveRecord::Migration[5.1]
  def change
    create_table :fgroups do |t|
      t.boolean :example
      t.string :description
      t.string :name
      t.timestamps
    end
  end
end
