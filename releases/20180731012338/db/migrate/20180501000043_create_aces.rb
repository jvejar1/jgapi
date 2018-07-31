class CreateAces < ActiveRecord::Migration[5.1]
  def change
    create_table :aces do |t|
      t.integer :version
      t.boolean :current

      t.timestamps
    end
  end
end
