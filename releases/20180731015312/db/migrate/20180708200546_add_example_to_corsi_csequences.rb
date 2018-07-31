class AddExampleToCorsiCsequences < ActiveRecord::Migration[5.1]
  def change
    add_column :corsi_csequences, :example, :boolean
  end
end
