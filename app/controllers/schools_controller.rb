class SchoolsController < ApplicationController
  def get_all
    @schools=School.all
    render :json => {schools:@schools}
  end

  def students #by school_id
    school=School.find(params[:id])
    @students=school.students
    render :json =>{id:school.id,students:@students}
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
