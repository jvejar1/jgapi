class AddIdRutToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :id_rut, :bigint
  end
end
