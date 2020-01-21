require File.expand_path('../../config/environment', __FILE__)


# t2_schools = School.where("name like '%T2'")
#
# # get the students
#
# n_students_without_antecessor = 0
# students_without_antecessor= []
# antecessors_without_course = 0
# t2_schools.each do |t2_school|
#
#   puts 'processing school '+ t2_school.name
#   t2_courses = t2_school.courses
#   student_courses_associations = t2_courses.collect{|c| c.student_courses}.flatten
#   t2_students = student_courses_associations.collect{|sca| sca.student}.flatten
#   antecessors_schools =[]
#   t2_students.each do |t2_student|
#     antecessor = Student.where("name like ? AND last_name like ?","%#{t2_student.name}%", "%#{t2_student.last_name}%").where.not(id:t2_student.id).first
#
#     ##get antecessor school
#     if antecessor.nil?
#       students_without_antecessor<<t2_student
#       n_students_without_antecessor+=1
#
#       next
#     end
#
#     #puts antecessor.as_json
#     sucessor_course_association = StudentCourse.where(student_id: t2_student.id).last
#     antecessor_course_association =  StudentCourse.where(student_id: antecessor.id).last
#
#     if(antecessor_course_association.nil?)
#       antecessors_without_course+=1
#       next
#     end
#     antecessor_course = antecessor_course_association.course
#     antecessor_school = antecessor_course.school
#     sucessor_course = sucessor_course_association.course
#     sucessor_school = sucessor_course.school
#
#     puts antecessor_school.name+","+sucessor_school.name+","+ antecessor_course.get_full_name+","+sucessor_course.get_full_name
#     antecessors_schools<<antecessor_school
#   end
#   antecessors_schools = antecessors_schools.uniq
#   puts "antecessors_schools: "
#   antecessors_schools.each do |as|
#     puts as.name
#   end
# end
# puts n_students_without_antecessor
# puts antecessors_without_course
# students_without_antecessor.each do|s|
#   #get school
#   course_association =  StudentCourse.where(student_id: s.id).last
#   puts s.name+ " " + s.last_name
# end



ICSP_school_names = ['Escuela El carmen',
                     'Colegio Santa Beatriz',
                     'Colegio Villa Macul',
                     'Escuela Miravalle',
                     "Saint Maurice's",
                     'Liceo Dagoberto Godoy',
                     'Colegio Hernán Olguín Maibee',
                     'Colegio Teniente Dagoberto Godoy',
                     'Escuela Particular Jose A. Alfonso',
                     'Liceo Avenida Recoleta',
                     'Escuela Particular Iberoamericana',
                     'Fundacion Educacional Presidente Abraham Lincoln'

]

ICS_t2_school_names = ['Escuela El Carmen_T2',
                       'Colegio Santa Beatriz_T2',
                       'Colegio Villa Macul_T2',
                       'Escuela Miravalle_T2',
                       "Colegio Saint Maurice's_T2",
                       'Liceo Teniente Dagoberto Godoy_T2',
                       'Colegio Hernán Olguín Maibée_T2',
                       'Colegio Teniente Dagoberto Godoy_T2',
                       'Escuela José A. Alfonso_T2',
                       'Liceo Avenida Recoleta_T2',
                       'Escuela Iberoamericana_T2',
                       'Fundación Eduacional Presidente Abraham Lincoln_T2',
]
=begin

schools = School.where(name:ICS_t2_school_names)
all_students_ids =[]
n_missing_clones = 0
schools.each do |school|

  courses = school.courses
  courses.each do |course|

    student_ids= StudentCourse.where(course_id:course.id).collect{|sc| sc.student_id}
    all_students_ids.concat(student_ids)
    students = Student.where(id:student_ids)
    students.each do |student|


      #search the student that matches the name and last_name
      clone =  Student.where("name like ? AND last_name like ?","%#{student.name}%", "%#{student.last_name}%").where.not(id:student.id).first

      #puts course.get_full_name()
      if clone.nil?
        n_missing_clones+=1
      end

    end
  end
end

puts 'missing_clones:' +n_missing_clones.to_s
puts 'total_students: ' +all_students_ids.count.to_s

=end



evaluations = Evaluation.where("realized_at>=Date'2019-2-28' AND (ace_id is NOT NULL OR wally_id is NOT NULL)").where.not(user_id:1)
n_evals = 0
n_aces_evals = 0
n_wally_evals = 0
n_missing_clones = 0
schools = []
students_without_clone =[]
clones_info = []

clones_info<< "fecha,aces,wally,colegio, colegio_clon, curso, curso_clon,nombre,nombre_clon,nombre=apellido"
school_pairs =[]
school_pairs_aces = {}
school_pairs_wally ={}
school_aces= {}
school_wally={}
ICSP_school_names.each do |school_name|
  school_aces[school_name] = 0
  school_wally[school_name] = 0
end
student_ids_with_course = StudentCourse.all.collect{|sc| sc.student_id}
evaluations.each do |eval|
  student = eval.student
  evaluation_year = eval.realized_at.year
  student_course = StudentCourse.where('EXTRACT (year from entry )= ? AND student_id =? ',evaluation_year,student.id).first
  course = Course.find(student_course.course_id)
  school =course.school

  student_in_target_school = ICSP_school_names.include?school.name

  if not student_in_target_school
    next
  end

  if not (schools.include?school.name)
    schools<<school.name
  end

  #if eval.realized_at.month>9
  #  next
  #end
  #




  #get the clone
  clones =  Student.where(id:student_ids_with_course).where("name like ? AND last_name like ?","%#{student.name}%", "%#{student.last_name}%").where.not(id:student.id)
  has_clone = false



  clone = nil
  clone_name = ""
  clone_course = ""
  clone_school = ""
  clones.each do |possible_clone|
    clone_name = possible_clone.get_full_name()
    clone_course = StudentCourse.where('EXTRACT (year from entry )= ? AND student_id =? ',evaluation_year,possible_clone.id).first.course
    clone_school = clone_course.school.name
    clone_course = clone_course.get_full_name()

    school_index = ICSP_school_names.index(school.name)
    clone_school_index = ICS_t2_school_names.index(clone_school)
    if (school_index==clone_school_index)
      has_clone = true
      clone = possible_clone
      break
    end
  end
  #puts course.get_full_name()
  #

  if not has_clone
    n_missing_clones+=1
    students_without_clone<< student.get_full_name()+ "," + school.name+ "," +course.get_full_name()
    next
  end

  school_pair = school.name+" "+course.get_full_name()+","+clone_school+" "+clone_course
  if not school_pairs.include?school_pair
    school_pairs<<school_pair
    school_pairs_aces[school_pair]= 0
    school_pairs_wally[school_pair] =0
  end

  is_aces = 0
  is_wally = 0
  if not (eval.ace_id.nil?)
    n_aces_evals+=1
    is_aces = 1
  elsif not (eval.wally_id.nil?)
    n_wally_evals+=1
    is_wally=1
  else
    next
  end


  school_aces[school.name]+=is_aces
  school_wally[school.name]+=is_wally

  school_pairs_aces[school_pair]+=is_aces
  school_pairs_wally[school_pair]+=is_wally
  same_name_and_last_name = (student.name.include?student.last_name) or (student.last_name.include?student.name) or (student.name==student.last_name)

  clones_info<< "'"+eval.realized_at.to_formatted_s(:long)+ "',"+ is_aces.to_s+ "," +is_wally.to_s+ ","+school.name+","+ clone_school+ ","+ course.get_full_name()+ "," +clone_course+"," +student.get_full_name()+","+ clone_name+","+ same_name_and_last_name.to_s


  #migrate the evaluation to the clone

  cloned_evaluation = Evaluation.where(student_id:clone.id, realized_at:eval.realized_at, created_at:eval.created_at).first

  evaluation_hasnt_been_cloned = cloned_evaluation.nil?
  if evaluation_hasnt_been_cloned
    clone_eval = eval.dup
    clone_eval.student_id = clone.id
    clone_eval.created_at = eval.created_at
    clone_eval.updated_at = eval.updated_at

    #clone the asosiations of the ansers

    #AcaseAnswer.where(evaluation_id: eval.id).update_all(evaluation_id:clone_eval.id)

    #save the cloned evaluation

    clone_eval.save(touch:false)

    #duplicate the answers
    answers = []
    answers<<eval.acase_answers
    answers<<eval.wsituation_answers
    answers = answers.flatten()

    answers.each do |answer|
      answer_dup = answer.dup
      answer_dup.created_at = answer.created_at
      answer_dup.updated_at = answer.updated_at
      answer_dup.evaluation_id =clone_eval.id
      answer_dup.save(touch:false)
    end


    EvaluationMigration.create(evaluation_from:eval, evaluation_to: clone_eval)


    n_evals +=1
  end

  #eval.save
  #puts school.name
  #puts course.get_full_name()

end
puts "evaluaciones migradas,"+ n_evals.to_s
puts "total_aces,"+n_aces_evals.to_s
puts "total_wally,"+n_wally_evals.to_s
puts ""
puts "escuelas involucradas:"+schools.count.to_s+",+aces,wally"
schools.each do |school|
  puts school+","+school_aces[school].to_s+","+school_wally[school].to_s
end
puts ""
puts "pares de escuela,,aces,wally"
school_pairs.each do |school_pair|
  puts school_pair+","+school_pairs_aces[school_pair].to_s+","+school_pairs_wally[school_pair].to_s
end

puts ""
students_without_clone = students_without_clone.uniq
puts "estudiantes sin clon válido,"+students_without_clone.count.to_s
puts students_without_clone

puts ""

puts clones_info

