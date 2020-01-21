icps_old = Study.where(name:"ICPS").first
schools = icps_old.get_schools
schools.each do |school|
  school.name = school.name+"_OLD"
  school.save
end

icps_old.moments.delete_all
icps_old.study_courses.delete_all
icps_old.delete

icps = Study.where(name:"ICPS T2 2019").first
icps.name = "ICPS"
icps.save

schools = icps.get_schools
schools.each do |school|
  school.name = school.name.gsub("_T2","")
  school.save
end