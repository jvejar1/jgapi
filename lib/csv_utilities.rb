require 'csv'

def get_evaluation(evaluations, moment, student)
  #we need the type of evaluation
  evaluations.where(created_at: moment.from..moment.until, student:student).first
end

def generate_csv_headers(test, study, moments)
  headers = []
  headers.concat(Student.get_headers)
  moments.each do |moment|
    moment_index = study.get_moment_index(moment)
    headers << study.get_moment_name(moment)
    headers.concat(Evaluation.get_headers(moment_index.to_s))
    headers.concat (test.get_headers(moment_index.to_s))
  end
  headers
end

def get_void_results(count)
  ['']*count
end

def get_results(test, evaluation)
  begin
    test.get_selections_and_scores(evaluation)
  rescue NoMethodError =>  e
    puts e
    get_void_results(test.get_headers(nil.to_s).count)
  end
end


def get_realization_flag(evaluation)
  if evaluation.nil?
    0
  else
    1
  end
end

def get_course(student, date)
  return StudentCourse.where('student_id = ? AND EXTRACT(year from entry) = ?',student,date.year).first.course
end

def get_group(study, course)
  return StudyCourse.where(study:study, course:course).first.group
end

def generate_csv_string(csv_lines)
  csv_string=CSV.generate do |csv|
    csv_lines.each do |csv_line|
      csv << csv_line
    end
  end
  csv_string
end


def generate_file(test:, study:, evaluation_class:, schools:, moments:)
  csv_lines = generate_csv_lines(test: test, study: study, evaluation_class: evaluation_class, schools: schools,moments: moments)
  generate_csv_string(csv_lines)
end


def generate_csv_lines(test:, study:, evaluation_class:, schools:, moments:)
  csv_lines = []

  csv_lines << generate_csv_headers(test, study, moments)
  baseline = study.get_baseline_moment
  courses = get_courses(schools, study)
  students = courses.collect{|course| course.get_students(baseline.from.year)}.flatten
  evaluations = test.evaluations

  students.each do |student|
    row = []
    row.concat(student.get_info)
    course =get_course(student, baseline.from)
    row<< course.school.name
    row<< get_group(study,course)
    moments.each do |moment|
      #get the evaluation associated to this moment, for this student, and puts his info in the csv
      evaluation = get_evaluation(evaluations, moment, student)
      row << get_realization_flag(evaluation)
      row << get_course(student, moment.from).to_string
      row.concat( evaluation_class.get_info(evaluation))
      row.concat(get_results(test,evaluation))
    end
    csv_lines<<row
  end
  csv_lines
end

def get_courses(schools, study)
  study.courses.where(school:schools)
end
