class StudentInserter<Inserter
  require 'date'
  def required_fields
    return @model_field_by_csv_field.keys
  end
  def initialize(course_id)
    @course_id=course_id
    @correct_rows=0
    @incorrect_rows=0
    @model_field_by_csv_field=Hash({"Nombre"=>"name","Apellido"=>"last_name","Rut"=>"rut", "Id"=>'id_rut'})
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
    student=Student.create(name:name,last_name:last_name,rut:rut,id_rut:id_rut)
    if student.errors.any?
      puts student.errors.as_json
      @incorrect_rows+=1
    else

      course_association = StudentCourse.create(student_id:student.id, course_id: @course_id, entry: DateTime.now)
      @correct_rows+=1

    end
    #create the student and sum to student_created or student_creation_failed
  end
end