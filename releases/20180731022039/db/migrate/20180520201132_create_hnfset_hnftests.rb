class CreateHnfsetHnftests < ActiveRecord::Migration[5.1]
  def change
    create_table :hnfset_hnftests do |t|
      t.references :hnfset, foreign_key: true
      t.references :hnftest, foreign_key: true

      t.timestamps
    end
  end
end
