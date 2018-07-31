class CreateHnftestFigures < ActiveRecord::Migration[5.1]
  def change
    create_table :hnftest_figures do |t|
      t.integer :figure
      t.integer :index
      t.integer :position

      t.timestamps
    end
  end
end
