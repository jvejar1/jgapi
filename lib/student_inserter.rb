class StudentInserter<Inserter
  require 'date'
  def required_fields
    return @model_field_by_csv_field.keys
  end

  def initialize(course_id)
    @course_id=course_id
    @has_course_name = nil
    @school_id = nil
    @has_course_name=has_course_name
    @correct_rows=0
    @incorrect_rows=0
    @model_field_by_csv_field=Hash({"Nombre"=>"name","Apellido"=>"last_name","Rut"=>"rut", "Id"=>'id_rut'})
  end

  def initialize(school_id, year, replace_with_rut=true)
    @courses = []
    @replace_with_rut = replace_with_rut
    @has_course_name=true
    @ncourses = 0
    @nschools = 0
    @school_id = school_id
    @year = year
    @correct_rows=0
    @incorrect_rows=0
  end
  
  def initialize()
    @courses = []
    @schools = []
    @replace_with_rut = true
    @using_course_name=true
    @using_school_name=true
    @ncourses = 0
    @nschools = 0
    @correct_rows=0
    @inserted_rows=0
    @updated_rows=0
    @incorrect_rows=0
    @not_changed_rows=0
    @errors=[]
  end

  def set_participants_file(participants_file)
    @participants_file = participants_file
  end

  def have_errors?
    !@errors.empty?
  end

  def get_errors_rows
    @errors
  end
  
  @@required_fields_with_course=["Nombre","Apellido","Rut","Id", "Curso"]
  def self.required_fields_with_course
    @@required_fields_with_course
  end

  @@required_fields_with_school_and_course=["Nombre","Apellido","Rut","Id", "Colegio", "Curso"]
  def self.required_fields_with_school_and_course
    @@required_fields_with_school_and_course
  end

  @@required_fields=["Nombre","Apellido","Rut","Id"]
  def self.required_fields
    @@required_fields
  end

  def report_str
    "(CSV) #{@inserted_rows} filas insertadas, #{@updated_rows} filas actualizadas, #{@not_changed_rows} correctas sin cambios, #{@incorrect_rows} filas incorrectas,  #{@nschools} escuelas,#{@ncourses} cursos distintos.\n
    Cursos:
    #{@courses.join(",")}"
  end

  def get_correct_rows
    @correct_rows
  end
  def get_rejected_rows
    @incorrect_rows
  end

  def insert_using_participants_file(row)
    puts row
    row_idx = row["index"]
    id_rut = row["Id"]
    rut=row["Rut"]
    rut = "" if rut.blank?
    name=row["Nombre"]
    last_name=row["Apellido"]
    course_name =row["Curso"]
    school_name =row["Colegio"]
  
    id_rut = id_rut.strip.upcase unless id_rut.blank?
    rut = rut.strip.upcase unless rut.blank?
    name=name.upcase.strip unless name.nil?
    last_name= last_name.upcase.strip unless last_name.nil?
    course_name = course_name.strip.upcase unless course_name.nil?
    
    school = @participants_file.schools.where(name:school_name).first
    if school.nil?
      school = School.create(name:school_name)
      @participants_file.schools<<school
      school.save
    end

    course = school.courses.where(name:course_name).first
    if course.nil?
      course = Course.create(name:course_name)
      school.courses<< course
      course.save
    end
    
    entry = Date.today
    unless id_rut.blank? #replacement with id_rut
      all_student_ids = @participants_file.schools.map{|s| s.courses}.flatten.map{|c| c.student_courses}.flatten.map{|sc| sc.student_id}.flatten
      all_students = Student.where(id: all_student_ids)
      old_student = all_students.where(id_rut: id_rut).first
      unless old_student.nil?
        @updated_rows+=1
        old_student.update(name:name, last_name:last_name, rut:rut)
        old_course_assoc = @participants_file.schools.map{|s| s.courses}.flatten.map{|c| c.student_courses}.flatten.select{|sc| sc.student_id == old_student.id}.first
        old_course = Course.find(old_course_assoc.course_id)
        old_course_is_current_course = old_course.id == course.id
        unless old_course_is_current_course
          old_course.students.delete(old_student)
          StudentCourse.create(course:course, entry:entry, student:old_student)
        end
      else
        student = Student.new(name:name, last_name:last_name, rut:rut, id_rut:id_rut)
        student.save
        StudentCourse.create(course:course, entry:entry, student:student)
        @inserted_rows+=1
      end
    else
      old_student_current_course = course.students.where(name: name, last_name:last_name, rut:rut).first
      if old_student_current_course.nil?
        student = Student.new(name:name, last_name:last_name, rut:rut)
        student.save
        StudentCourse.create(course:course, entry:entry, student:student)
        @inserted_rows+=1
      else
        @incorrect_rows+=1
        @errors<<"(CSV) Alcance de nombre y rut en el curso para la fila ##{row_idx+1}: #{row.fields.join(",")}. Cambie el rut."
      end
    end

  end

  def insert(row)
    id_rut = row["Id"]
    rut=row["Rut"]
    name=row["Nombre"]
    last_name=row["Apellido"]
    course_name =row["Curso"]
    
    
    id_rut = id_rut.strip.upcase unless id_rut.nil?
    rut = rut.strip.upcase unless rut.nil?
    name=name.upcase.strip unless name.nil?
    last_name= last_name.upcase.strip unless last_name.nil?
    course_name = course_name.strip.upcase unless course_name.nil?
    
    if @replace_with_rut and !rut.blank? and !rut.nil?
      student = Student.where(rut: rut).first
      if student.nil?
        student=Student.new(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
      end
    else
      student=Student.new(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
    end

    if student.errors.any?
      @incorrect_rows+=1
      return
    else

    unless course_name.nil? 
      course_name = course_name.strip
      school = School.find(@school_id)
      course = school.courses.find_by(name: course_name, year:@year)
      if (course.nil?)
          course = Course.create(school_id: school.id, name: course_name, year:@year)
          @ncourses+=1
          @courses<< course.name
      end
      
      entry = DateTime.new(@year,01,01)
      
      student_in_course = course.students.where(name: name, last_name:last_name, rut:rut).first
      if student_in_course.nil?
        student=Student.new(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
        student.save
      else
        student = student_in_course
      end
      
      course_association = StudentCourse.where(student_id:student.id, course_id:course.id).first
      if course_association.nil?
        StudentCourse.create(student_id:student.id, course_id: course.id, entry: entry)
        @correct_rows+=1
      end
      return
    end

    student.save
    course_association = StudentCourse.where(student_id:student.id, course_id: @course_id).first
      if course_association.nil?
        course_association = StudentCourse.create(student_id:student.id, course_id: @course_id, entry: DateTime.now)
        @correct_rows+=1
      end
    end
    #create the student and sum to student_created or student_creation_failed
  end
end