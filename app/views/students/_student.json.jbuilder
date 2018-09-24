json.extract! student, :id, :name, :last_name, :rut, :age, :course_id, :created_at, :updated_at
json.url student_url(student, format: :json)
