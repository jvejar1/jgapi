class StudentInserter<Inserter
  def required_fields
    return @model_field_by_csv_field.keys
  end
  def initialize(course_id)
    @course_id=course_id
    @correct_rows=0
    @incorrect_rows=0
    @model_field_by_csv_field=Hash({"Nombre"=>"name","Apellido"=>"last_name","Rut"=>"rut"})
  end

  def insert(row)
    rut=row["Rut"]
    name=row["Nombre"]
    last_name=row["Apellido"]
    student=Student.create(name:name,last_name:last_name,rut:rut,course_id:@course_id)
    if student.errors.any?
      puts student.errors.as_json
    end
    #create the student and sum to student_created or student_creation_failed
  end
end