class SchoolsController < ApplicationController
  def get_all
    @schools=School.all
    render :json => {schools:@schools}
  end

  def students #by school_id
    school=School.find(params[:id])
    @students=school.students

    courses_by_id=school.courses.index_by(&:id)
    puts courses_by_id
    formatted_students=[]
    @students.each do |student|

      course=courses_by_id[student.course_id]
      student_json=student.as_json
      puts student.course_id
      student_json[:course_level]=course[:level]
      student_json[:course_letter]=course[:letter]
      student_json[:server_id]=student.id
      student_json[:school_name]=school.name
      student_json.delete("id")
      student_json.delete("course_id")
      student_json.delete("created_at")
      student_json.delete("updated_at")

      formatted_students<<student_json

    end

    render :json =>{id:school.id,name:school.name,formatted_students:formatted_students,students:formatted_students,courses_by_id:courses_by_id}
  end

  def schools_and_courses
    schools=School.all
    @courses=[]

    schools.each do |school|
      school.courses.each do |course|
        @courses.push(course)
      end
    end
    puts @courses.as_json
    @courses_as_arr=[]
    @courses.each do |course|
      course_as_json=course.as_json
      school_name=course.school.name
      course_as_json[:school_name]=school_name
      @courses_as_arr<<course_as_json
    end
    @schools_by_school_id=School.all.index_by(&:id)
    render json:{courses:@courses_as_arr,schools:schools}

  end
end
