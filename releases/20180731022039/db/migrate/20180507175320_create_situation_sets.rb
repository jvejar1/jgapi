class CreateSituationSets < ActiveRecord::Migration[5.1]
  def change
    create_table :situation_sets do |t|
      t.references :wally, foreign_key: true
      t.references :wsituation, foreign_key: true
      t.integer :index
      t.timestamps
    end
  end
end
