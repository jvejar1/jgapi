class CreateCorsis < ActiveRecord::Migration[5.1]
  def change
    create_table :corsis do |t|
      t.decimal :version
      t.boolean :current

      t.timestamps
    end
  end
end
