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
    @school_id = school_id
    @year = year
    @correct_rows=0
    @incorrect_rows=0
  end
  
  @@required_fields_with_course=["Nombre","Apellido","Rut","Id", "Curso"]
  def self.required_fields_with_course
    @@required_fields_with_course
  end

  @@required_fields=["Nombre","Apellido","Rut","Id"]
  def self.required_fields
    @@required_fields
  end

  

  def report_str
    "#{@correct_rows} filas correctas, #{@incorrect_rows} filas incorrectas, #{@ncourses} cursos distintos.\n
    Cursos:
    #{@courses.join(",")}
    "
  end

  def get_correct_rows
    @correct_rows
  end
  def get_rejected_rows
    @incorrect_rows
  end

  def insert(row)
    id_rut = row["Id"]
    rut=row["Rut"]
    
    unless rut.nil?
      rut=rut.strip.upcase
    end

    name=row["Nombre"]
    name= name.upcase unless name.nil?
    last_name=row["Apellido"]
    last_name= last_name.upcase unless last_name.nil?
    
    if @replace_with_rut and !rut.blank? and !rut.nil?
      student = Student.where(rut: rut).first
      if student.nil?
        student=Student.new(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
      end
    else
      student=Student.new(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
    end

    if student.errors.any?
      puts student.errors.as_json
      @incorrect_rows+=1
      return
    else

    course_name =row["Curso"]
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