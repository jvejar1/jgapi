class Student < ApplicationRecord
  belongs_to :course
  validates :course, :rut, presence:true
  validate :validate_rut

  def validate_rut

    if rut.present? && rut==""
      errors.add(:rut,"No puede ser vacío")

    elsif (rut.present? && !rut.scan(/\D/).empty?)
      errors.add(:rut,"Solo debe contener números, reemplace las K's por ceros, elimine puntos y guiones")
    end
  end
end