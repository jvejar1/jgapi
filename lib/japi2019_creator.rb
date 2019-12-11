require File.expand_path('../../config/environment', __FILE__)


def get_courses(schools_names)
  School.where(name:schools_names).collect{|school| school.courses}.flatten
end

study = Study.create(name:'Japi 2019')
t0_from = Date.new(2019, 01, 31)
t0_until = Date.new(2019, 12, 31)
t0_moment = Moment.create(from: t0_from, until: t0_until, study:study)

#integreate the schools

control_school_names = ['Colegio Tomás Moro',
                        'Colegio San Fernando',
                        'Colegio Crisol',
                        'Colegio Marquel',
                        'Colegio Huelén',
                        'Colegio Cantagallo']


control_courses = get_courses(control_school_names)
control_courses.each do |course|
  StudyCourse.create(study:study,group: Study.CONTROL, course:course)
end

