class StudentInserter<Inserter
  require 'date'
  def required_fields
    return @model_field_by_csv_field.keys
  end

  def required_fields_with_course_name
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

  def initialize(school_id, year)
    @courses = []
    @has_course_name=true
    @ncourses = 0
    @school_id = school_id
    @year = year
    @correct_rows=0
    @incorrect_rows=0
    @model_field_by_csv_field=Hash({"Nombre"=>"name","Apellido"=>"last_name","Rut"=>"rut", "Id"=>'id_rut', "Curso"=>"Curso"})
  end

  def report_str
    "#{@correct_rows} filasaaa correctas, #{@incorrect_rows} filas incorrectas, #{@ncourses} cursos distintos.\n
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
    name=row["Nombre"]
    last_name=row["Apellido"]
    student=Student.new(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
    
    if student.errors.any?
      puts student.errors.as_json
      @incorrect_rows+=1
    else

    student.save
    if (@has_course_name)
      course_name =row["Curso"]
      course_name = course_name.strip
      school = School.find(@school_id)
      course = school.courses.find_by(name: course_name, year:@year)
      if (course.nil?)
          course = Course.create(school_id: school.id, name: course_name, year:@year)
          @ncourses+=1
          @courses<< course.name
      end
      
      entry = DateTime.new(@year,01,01)
      StudentCourse.create(student_id:student.id, course_id: course.id, entry: entry)
      @correct_rows+=1
      return
    end
    
    course_association = StudentCourse.create(student_id:student.id, course_id: @course_id, entry: DateTime.now)
    @correct_rows+=1

    end
    #create the student and sum to student_created or student_creation_failed
  end
end