require File.expand_path('../../config/environment', __FILE__)

def get_courses(schools_names)
  School.where(name:schools_names).collect{|school| school.courses}.flatten
end

study = Study.create(name:'Japi')
japi_basal_from = Date.new(2018, 8, 28)
japi_basal_until = Date.new(2018, 10, 31)
japi_basal = Moment.create(from: japi_basal_from, until: japi_basal_until, study:study)
#seguimiento

japi_followup_from = Date.new(2018,11,13)
japi_followup_until = Date.new(2018,12,06)
japi_followup = Moment.create(from: japi_followup_from, until: japi_followup_until, study:study)

#integreate the schools

intervention_schools_names = ['Regina Mundi',
                              'Ernestina Krischuk',
                              'Lo Franco',
                              'El Trebol']
control_school_names = ['San Marcelo',
                        'Maestra Elsa Santibañez',
                        'Alberto Magno',
                        'Elvira Santa Cruz Ossa']

intervention_courses = School.where(name:intervention_schools_names).collect{|school| school.courses}.flatten

intervention_courses.each do |intervention_course|
  StudyCourse.create(study:study,group: Study.INTERVENTION, course:intervention_course)
end
control_courses = get_courses(control_school_names)
control_courses.each do |course|
  StudyCourse.create(study:study,group: Study.CONTROL, course:course)
end



acps_study = Study.create(name:'ICPS')
#moments
basal = Moment.create(from: Date.new(2019,4,4), until: Date.new(2019,6,24), study: acps_study)

#courses
intervention_school_names =['Colegio Villa Macul',
                            "Escuela Miravalle",
                            "Escuela El carmen",
                            "Liceo Dagoberto Godoy",
                            "Saint Maurice's",
                            "Colegio Santa Beatriz"]


intervention_courses = get_courses(intervention_school_names)
intervention_courses.each do |course|
  StudyCourse.create(course:course, study:acps_study, group: Study.INTERVENTION)
end


control_school_names = ["Colegio Teniente Dagoberto Godoy",
                        "Escuela Particular Iberoamericana",
                        "Escuela Particular Jose A. Alfonso",
                        "Fundacion Educacional Presidente Abraham Lincoln","Liceo Avenida Recoleta", "Colegio Hernán Olguín Maibee"]

control_courses = get_courses(control_school_names)

control_courses.each do |course|
  StudyCourse.create(course: course, study: acps_study, group: Study.CONTROL )
end



def get_courses(schools_names)
  School.where(name:schools_names).collect{|school| school.courses}.flatten
end

study_name = "ICPS T2 2019"
study =Study.create(name: study_name)
basal_from = Date.new(2019,01,01)
basal_until = Date.new(2019,12,12)
study_basal = Moment.create(from: basal_from, until:basal_until, study_id:study.id)

control_school_names = ["Colegio Teniente Dagoberto Godoy_T2",
                        "Escuela Iberoamericana_T2",
                        "Escuela José A. Alfonso_T2",
                        "Fundación Eduacional Presidente Abraham Lincoln_T2",
                        "Liceo Avenida Recoleta_T2",
                        "Colegio Hernán Olguín Maibée_T2",
                        "Colegio Santa Beatriz_T2",
                        "Colegio Saint Maurice's_T2",
                        "Liceo Teniente Dagoberto Godoy_T2",
                        "Escuela El Carmen_T2",
                        "Colegio Villa Macul_T2",
                        "Escuela Miravalle_T2"]

schools = School.where(name:control_school_names).collect{|school| school.name}
courses =  get_courses(schools)
courses.each do |course|
  StudyCourse.create(study_id: study.id, course_id: course.id, group:Study.CONTROL)
end
