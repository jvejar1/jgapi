class AddDeletedToInstruments < ActiveRecord::Migration[5.1]
  def change
    add_column :instruments, :deleted, :boolean, :default=>false
  end
end
