def process_student_csv(file_path)
  require 'csv'
  csv=CSV.read(file_path,headers:true)
  headers={nombre:"Nombre",apellido:"Apellido",rut:"Rut"}
  csv.each do |row|
    name=row[headers[:nombre]].upcase
    last_name=row[headers[:apellido]].upcase
    rut=row[headers[:rut]]
    #process rut
    rut=rut.split('.').join('').split('-').join('')
    student_attr={name:name,last_name:last_name,rut:rut}

    Student.create(student_attr)
    puts student_attr
  end

end
