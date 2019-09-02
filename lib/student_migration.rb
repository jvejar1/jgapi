students_2018 = Student.where('created_at <= ?',Date.new(2018,12,31))
students_2019 = Student.where('created_at >= ?',Date.new(2019,01,01))
entry_2018 = Date.new(2018,01,01)
students_2018.each do |student_2018|
  sc = StudentCourse.new(student:student_2018, course: student_2018.course, entry: entry_2018)
  sc.save
end

entry_2019 = Date.new(2019,01,01)
students_2019.each do |student_2019|
  sc = StudentCourse.new(student:student_2019, course: student_2019.course, entry:entry_2019)
  sc.save
  puts sc.as_json
end