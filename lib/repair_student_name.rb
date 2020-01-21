require File.expand_path('../../config/environment', __FILE__)

inflector = ActiveSupport::Inflector
all_students = Student.all
edited_students = 0
edition_info = []
all_students.each do |s|


  student_name_change = StudentNameChange.new(student_id:s.id, old_name: s.name, old_last_name: s.last_name)
  full_name_length_i = s.get_full_name().length

  prev_name =  s.get_full_name()


  #delete accents
  s.name = inflector.transliterate(s.name)
  s.last_name = inflector.transliterate(s.last_name)




  #delete the blank spaces at the begin, at the end, and the repeated spaces
  #
  s.name =s.name.strip
  s.last_name = s.last_name.strip

  s.name = s.name.squeeze(" ")
  s.last_name = s.last_name.squeeze(" ")


  s.name = s.name.gsub(",", "")
  s.last_name = s.last_name.gsub(",", "")

  full_name_length_f = s.get_full_name.length

  name_length_difference = full_name_length_i -full_name_length_f
  name_length_difference = name_length_difference.abs()

  post_name = s.get_full_name()


  student_was_edited = prev_name!= post_name
  if student_was_edited
    edited_students+=1
    edition_info<< "'"+prev_name+"','"+post_name+"',"+name_length_difference.to_s

    student_name_change.new_name = s.name
    student_name_change.new_last_name = s.last_name
    student_name_change.save()

    s.save
  end



end

puts "total estudiantes editados,"+edited_students.to_s+","
puts "nombre original, nombre nuevo, cambio de largo"

puts edition_info
