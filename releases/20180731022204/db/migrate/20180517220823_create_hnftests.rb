class CreateHnftests < ActiveRecord::Migration[5.1]
  def change
    create_table :hnftests do |t|
      t.integer :hnf_type
      t.timestamps
    end
  end
end
