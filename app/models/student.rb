class Student < ApplicationRecord
  belongs_to :course
  #validates :course, presence:true
  validate :validate_rut
  before_save :clean_fields

  def clean_fields
    self.name=self.name.upcase
    self.last_name=self.last_name.upcase
  end

  def get_evaluations_number(test)
    test.get_evaluations.where(student:self).count
  end

  def validate_rut

    #
    # if rut.present? && rut==""
    #   errors.add(:rut,"No puede ser vacío")
    if (rut.present? && !rut.scan(/\D/).empty?)

       errors.add(:rut,"Solo debe contener números, reemplace las K's por ceros, elimine puntos y guiones")
    end

  end
end