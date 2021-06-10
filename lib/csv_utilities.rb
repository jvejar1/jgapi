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
  sc = StudentCourse.where('student_id = ? AND EXTRACT(year from entry) = ?',student.id,date.year).first
  if sc.nil?
    sc = StudentCourse.where('student_id = ?',student.id).first
  end
  return sc.course
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

def generate_csv_str(instrument, items, study, moments, students)
  csv_lines = []
  headers = []
  headers.concat(Student.get_headers)
  moments.each_with_index do |moment, moment_idx|
    moment_index = study.get_moment_index(moment)
    headers << study.get_moment_name(moment)
    headers+= ["course_#{moment_idx}", "evaluator_#{moment_idx}","application_date_#{moment_idx}","server_date_#{moment_idx}"]

    items.each_with_index do |item, item_idx|
      suffix = "#{item.reportable_index}_#{moment_idx}"
      if item.report_header_prefix_choice_value
        headers << item.report_header_prefix_choice_value + suffix
      end
      if item.report_header_prefix_choice_text
        headers << item.report_header_prefix_choice_text + suffix
      end
      if item.report_header_prefix_score
        headers << item.report_header_prefix_score + suffix
      end
    end
    instrument.constructs.each do |construct|
      headers << construct.name+"_#{moment_idx}"
    end
  end
  csv_lines<<headers
  baseline = study.get_baseline_moment
  evaluations = Evaluation.where(instrument:instrument)
  students.each do |student|
    row = []
    row.concat([student.id_rut.to_s, student.rut.to_s, student.get_full_name])
    course =get_course(student, baseline.from)
    row<< course.school.name
    group = study.study_courses.where(course_id: course.id).first.group
    row<< group
    moments.each_with_index do |moment, moment_idx|
      #get the evaluation associated to this moment, for this student, and puts his info in the csv
      evaluation = get_evaluation(evaluations, moment, student)
      row << get_realization_flag(evaluation)
      row << get_course(student, moment.from).to_string
      row.concat( Evaluation.get_info(evaluation))

      items.each_with_index { |item,index |
        if item.report_header_prefix_choice_value
          answer_value=""
          unless evaluation.nil?
            choice_answers = evaluation.choice_answers.where(choice_id: item.choices)
            if choice_answers[0].nil? || choice_answers.empty?
              answer_value = "null"
            else
              if choice_answers.count >1
                answer_value = choice_answers.map(&:choice).map(&:choice_value).join (" - ")
              else
                answer_value = choice_answers[0].choice.choice_value
              end
            end
          end
          row<<answer_value
        end
        if item.report_header_prefix_choice_text
          choice_text=""
          unless evaluation.nil?
            choice_answers = evaluation.choice_answers.where(choice_id: item.choices)
            choice_text = choice_answers.map{|ca| ca.choice.choice_text}.join(" - ")
          end
          row<< choice_text
        end
        if item.report_header_prefix_score
          answer_score=""
          unless evaluation.nil?
            choice_answers = evaluation.choice_answers.where(choice_id: item.choices)
            answer_score = choice_answers.map(&:score).reduce(0,:+)
          end
          row<<answer_score
        end
        }
      #the total score, or the maths over the items.
      instrument.constructs.each do |construct|
        construct_score =""
        if not evaluation.nil?
          if construct.calculation_type_id == 1
            #total score obtenido en los items
            construct_score = evaluation.choice_answers.pluck(:score).reduce(0, :+)
          elsif construct.calculation_type_id == 2
            construct_score = "*calculated_value type 2*"
            //#total tiempo invertido contestando items
          end
        end
        row<< construct_score
      end
    end
    csv_lines<<row
  end
  csv_str = csv_lines.map{|l| l.join(",")}.join("\n")
  csv_str
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
