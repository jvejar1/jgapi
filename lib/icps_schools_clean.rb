
require File.expand_path('../../config/environment', __FILE__)

t1_schools  = School.where("name like '%_T2'")
icps = Study.where("name like 'ICPS T2 2019'").first
icps.study_courses.delete_all

t1_schools.each do |school|

  courses = school.courses
  icps.courses<<courses

end
icps.save()



