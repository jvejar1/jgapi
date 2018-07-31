class CreateFonotests < ActiveRecord::Migration[5.1]
  def change
    create_table :fonotests do |t|
      t.decimal :version
      t.boolean :current
      t.string :description

      t.timestamps
    end
  end
end
