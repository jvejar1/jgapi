class CreateCsequences < ActiveRecord::Migration[5.1]
  def change
    create_table :csequences do |t|
      t.boolean :ordered
      t.timestamps
    end
  end
end
