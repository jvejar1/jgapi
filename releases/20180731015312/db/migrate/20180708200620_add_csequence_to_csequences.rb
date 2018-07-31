class AddCsequenceToCsequences < ActiveRecord::Migration[5.1]
  def change
    add_column :csequences, :csequence, :string
  end
end
