class CreateFonotestFgroups < ActiveRecord::Migration[5.1]
  def change
    create_table :fonotest_fgroups do |t|
      t.integer :index

      t.references :fonotest
      t.references :fgroup
      t.timestamps
    end
  end
end
