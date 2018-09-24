class Course < ApplicationRecord
  has_many :students, dependent: :destroy
  belongs_to :school
  validates :school_id, uniqueness: { scope: [:level, :letter], message:"Curso existente en el colegio"}
  validate :validate_level_and_letter
  @@course_levels_by_number={1=>"PRE - KINDER",
                             2=>"KINDER",
                             3=>"1° BASICO"}

  @@course_letter_by_number={1=>"A",
                             2=>"B",
                             3=>"C",
                             4=>"D"}

  def validate_level_and_letter
    if !@@course_levels_by_number.keys.include?(self.level)
      self.errors.add(:base,"Nivel inválido")
      return false
    elsif     !@@course_letter_by_number.keys.include?(self.letter)
      self.errors.add(:base,"Letra inválida")
      return false
    end

  end

  def to_string
  #  puts @@course_letter_by_number
    string = "#{self.school.name} - #{Course.course_level_hash[self.level]} #{Course.course_letter_hash[self.letter]}"
    puts string
    return string
  end

  def self.course_level_hash
    @@course_levels_by_number
  end
  def self.course_letter_hash
    @@course_letter_by_number
  end

end
