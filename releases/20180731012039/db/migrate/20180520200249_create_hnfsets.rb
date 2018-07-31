class CreateHnfsets < ActiveRecord::Migration[5.1]
  def change
    create_table :hnfsets do |t|
      t.boolean :current
      t.decimal :version

      t.timestamps
    end
  end
end
