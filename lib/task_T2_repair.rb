t2_study = Study.where(name:"ICPS T2 2019").first


schools_names = ["Escuela Particular Jose A. Alfonso",
                  "Colegio Teniente Dagoberto Godoy",
                  "Escuela Particular Iberoamericana","Liceo Avenida Recoleta", "Fundacion Educacional Presidente Abraham Lincoln"]

schools_ids = School.where(name:schools_names).collect{|s| s.id}
courses = Course.where(school_id:schools_ids)


courses.each do |course|

  study_course = StudyCourse.create(study_id: t2_study.id, course_id: course.id, group:0)

end