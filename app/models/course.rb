class Course < ApplicationRecord
  has_many :students
  @@course_levels_by_number={1=>"PRE - KINDER",
                             2=>"KINDER",
                             3=>"1° BASICO"}
  @@course_letter_by_number={1=>"A",
                             2=>"B",
                             3=>"C",
                             4=>"D"}
  belongs_to :school

end
