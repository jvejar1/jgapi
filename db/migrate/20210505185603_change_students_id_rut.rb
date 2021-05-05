class ChangeStudentsIdRut < ActiveRecord::Migration[5.1]
  def change
    change_column :students, :id_rut, :string
  end
end
