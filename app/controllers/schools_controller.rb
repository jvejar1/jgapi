class SchoolsController < ApplicationController

  before_action :set_school, only:[:show,:edit,:destroy,:update, :upload_students]

  before_action :check_permissions, except:[:students,:schools_and_courses]

  require 'csv'
  skip_before_action :authenticate_user!, only:[:students,:schools_and_courses]
  def check_permissions
    if current_user.can_admin_schools?
    else
      head(:forbidden)
    end
  end
  def index
    @schools=School.all
  end

  def destroy
    @school.destroy
    redirect_to schools_url, notice: "Escuela eliminada"
  end

  def show
    @required_fields = StudentInserter.required_fields_with_course
  end

  def new
    @school=School.new()
  end

  def update
    if @school.update(school_params)
      redirect_to @school, notice: "Escuela actualizada"

    else
      render :edit

    end
  end
  def create

    @school=School.new(school_params)

    if @school.save
      redirect_to @school
    else
      render :new , notice: "Error"
    end
  end

  def upload_students
  
    flash[:notice]= "metodo no implementado"
    redirect_to action: 'show', id: @school.id

  end



  def get_all
    @schools=School.all
    render :json => {schools:@schools}
  end

  def students #by school_id
    require 'date'
    school=School.find(params[:id])
    courses_ids = school.courses.collect{|c| c.id}
    courses_by_id=school.courses.index_by(&:id)
    @students = []

    school.courses.each do |course|
      @students.concat(course.get_students())
    end
    puts courses_by_id
    formatted_students=[]
    @students.each do |student|
      course_id = StudentCourse.where("student_id= ? AND EXTRACT (YEAR FROM ENTRY)=?",student.id, DateTime.now.year).first.course_id
      course=courses_by_id[course_id]
      student_json=student.as_json
      puts student.course_id
      student_json[:course_level]=course[:level]
      student_json[:course_letter]=course[:letter]
      student_json[:server_id]=student.id
      student_json[:school_name]=school.name
      student_json[:aces_count] = student.get_evaluations_number(Ace.first)
      student_json[:wally_count] = student.get_evaluations_number(Wally.first)
      student_json[:corsis_count] = student.get_evaluations_number(Corsi.first)
      student_json[:hnf_count] = student.get_evaluations_number(Hnfset.first)
      student_json[:fonotest_count] = student.get_evaluations_number(Fonotest.first)

      student_json.delete("id")
      student_json.delete("course_id")
      student_json.delete("created_at")
      student_json.delete("updated_at")

      formatted_students<<student_json

    end

    render :json =>{id:school.id,name:school.name,formatted_students:formatted_students,students:formatted_students,courses_by_id:courses_by_id,courses_ids:courses_ids}
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
  private
  def school_params
    params.require(:school).permit(:name)
  end
  def set_school
    @school=School.find(params[:id])
  end

  def set_csv_file
    
   
    
  end

end
