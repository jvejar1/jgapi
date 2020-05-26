#puc 2019
#
require File.expand_path('../../config/environment', __FILE__)
name= "PUC 2019"
puc = Study.where(name:name).first
exists = not(puc.nil?)
if exists
  puc.moments.delete_all
  puc.courses.delete_all
else
  puc =  Study.new(name:name)
end

#two moments
baseline_from= Date.new(2019,9,1)
baseline_until = Date.new(2019,10,17)
puc.moments<< Moment.new(from:baseline_from, until: baseline_until)

follow_up_from = Date.new(2019,10,19)
follow_up_until = Date.new(2019,12,31)
puc.moments<< Moment.new(from:follow_up_from, until: follow_up_until)



school_names = ["Colegio Guillermo Matta", "Colegio Arturo Matte Larraín"]

School.where(name:school_names).each do |school|
  courses = school.courses()
  puc.courses<< courses
end


puc.save()

#Courses