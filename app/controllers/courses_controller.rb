class CoursesController < ApplicationController
  require 'csv'
  before_action :set_school
  before_action :set_course, only: [:show,:upload_students,:edit,:destroy,:update]

  before_action :check_permissions
  before_action :set_csv_file, only:[:upload_students]

  def check_permissions
    if current_user.can_admin_courses?
      #
    else
      head(:forbidden)
    end
  end
  def show

  end
  def destroy
    @course.destroy
    redirect_to courses_url, notice: "Curso eliminado"
  end
  def update
    if @course.update(course_params)
      redirect_to course_url(@course), notice: "Curso actualizado"
    else
      render :update

    end


  end
  def index

    @courses=Course.all
  end
  def new
    @course=Course.new(school_id:@school_id)
  end

  def upload_students
    csvprocessor=CSVProcessor.new()
    student_inserter=StudentInserter.new(@course.id)
    begin
      csvprocessor.process(@csv_file,student_inserter,student_inserter.required_fields)

    rescue Exception =>e
      flash[:notice]=e.to_s
      render :show
    end

    flash[:notice]="Se ingresaron #{student_inserter.get_correct_rows} y "+
    "se rechazaron #{student_inserter.get_rejected_rows} filas"
    render :show


  end

  def create
    @course=Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Curso creado con exito'
    else

      render :new

    end

  end
  def edit

  end
  private
  def set_csv_file

    @csv_file=CSV.read(params.require(:csv_file).path,headers:true)
  end
  def set_school
    @school_id=params[:school_id]
  end
  def set_course
    @course = Course.find(params[:id])
  end
  def course_params
    params.require(:course).permit(:level,:letter,:school_id)
  end
end
