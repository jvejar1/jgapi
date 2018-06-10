class StudentInserter<Inserter
  def required_fields
    return @model_field_by_csv_field.keys
  end
  def initialize(school_id,school_level_id)
    @school_id=school_id
    @school_level_id=school_level_id
    @correct_rows=0
    @incorrect_rows=0
    @model_field_by_csv_field=Hash({"Nombre"=>"name","Apellido"=>"last_name","Rut"=>"rut"})
  end

  def insert(row)
    rut=row["Rut"]
    name=row["Nombre"]
    last_name=row["Apellido"]
    rut=rut.split('.').join('').split('-').join('').sub 'k','K'
    student=Student.create(name:name,last_name:last_name,rut:rut)
    StudentSchool.create(school_id:@school_id,school_level_id:@school_level_id,student_id:student.id)
    #create the student and sum to student_created or student_creation_failed
  end
end