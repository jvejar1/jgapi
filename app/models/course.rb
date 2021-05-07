class Course < ApplicationRecord
  require 'date'
  has_many :student_courses
  accepts_nested_attributes_for :student_courses, reject_if: proc {|attributes| attributes['course_id'].blank?}
  has_many :students, through: :student_courses

  accepts_nested_attributes_for :students, reject_if: proc {|attributes| attributes['name'].blank? and attributes['last_name'].blank?}
  belongs_to :school
  validate :validate_level_and_letter
  @@course_levels_by_number={1=>"PRE - KINDER",
                             2=>"KINDER",
                             3=>"1° BASICO"}

  @@course_letter_by_number={1=>"A",
                             2=>"B",
                             3=>"C",
                             4=>"D",
                              5=>"E"}

  def get_students(date_from, date_until)
    self.student_courses.where('entry >= ? AND entry<= ?',date_from, date_until).collect{|sc| sc.student}
  end
  def get_students(year=DateTime.now.year)
    self.student_courses.where('extract (year from entry) = ?',year).collect{|sc| sc.student}
  end

  def get_full_name()
    unless self.name.nil? or self.name.blank?
      return self.name
    end
    unless self.level.nil? or self.letter.nil?
      return @@course_levels_by_number[self.level] + ' '+ @@course_letter_by_number[self.letter]
    end
    return "sin nombre"
  end

  def name_with_school
    unless self.name.nil? or self.name.blank?
      name = self.name
      unless self.school.nil?
        name+=" - "+self.school.name
      end
      return name
    end

    unless self.level.nil? or self.letter.nil?
      return @@course_levels_by_number[self.level] + ' '+ @@course_letter_by_number[self.letter]
    end
  end

  def validate_level_and_letter
    
  end

  def to_string
  #  puts @@course_letter_by_number
    string = "#{self.school.name} - #{Course.course_level_hash[self.level]} #{Course.course_letter_hash[self.letter]}"
    return string
  end

  def self.course_level_hash
    @@course_levels_by_number
  end
  def self.course_letter_hash
    @@course_letter_by_number
  end

end
