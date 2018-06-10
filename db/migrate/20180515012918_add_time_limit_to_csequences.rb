class AddTimeLimitToCsequences < ActiveRecord::Migration[5.1]
  def change
    add_column :csequences, :time_limit, :integer
  end
end
