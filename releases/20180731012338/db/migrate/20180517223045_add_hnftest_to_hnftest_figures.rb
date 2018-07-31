class AddHnftestToHnftestFigures < ActiveRecord::Migration[5.1]
  def change
    add_reference :hnftest_figures, :hnftest, foreign_key: true
  end
end
