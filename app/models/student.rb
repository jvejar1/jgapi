class Student < ApplicationRecord
  belongs_to :course
  #validates :course, presence:true
  before_save :clean_fields

  def clean_fields

  end

  def get_evaluations_number(test)
    test.get_evaluations.where(student:self).count
  end

  def self.get_headers
    return ['id_rut', 'rut','nombre', 'school', 'group']
  end

  def get_info
    return [self.id_rut.to_s, self.rut, self.get_full_name]
  end

  def get_full_name
    return self.last_name.to_s + ' ' + self.name.to_s
  end

end