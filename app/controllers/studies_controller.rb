class StudiesController < ApplicationController
  # GET /aces
  # GET /aces.json
  skip_before_action :verify_authenticity_token
  def index
    @studies = Study.all
  end

  def show
    study_id=params[:id]
    @study=Study.find(study_id)
    @users= User.all
    @course_groups = @study.study_courses.order(:created_at).as_json(include: {course:{:include => :school, methods: :full_name}})
    @courses=Course.all
    @study_instruments =@study.study_instruments
    @study_instruments.build()
    @instruments = Instrument.active
    puts @course_groups
  end
  
  def create
    study_json = params.require(:study).permit(:name)
    study = Study.new(study_json)
    study.save
    unless study.valid?
      flash[:error] = study.errors.full_messages.join('\n')
    end
    redirect_back fallback_location:studies_path
  end

  def update
    study_id = params[:id]
    study = Study.find(study_id)
    study_json = params.require(:study).permit(:id, :name, study_instruments_attributes:[:id, :study_id, :instrument_id, :_destroy])
    study.update(study_json)
    unless study.valid?
      flash[:error] = study.errors.full_messages.join('\n')
    end
    redirect_back fallback_location:studies_path
  end

  def delete
    study_id = params[:id]
    study = Study.find(study_id)
    study.destroy

    redirect_to studies_path
  end


  def add_user
    user_id = params[:user]
    study_id = params[:id]
    study = Study.find(study_id)
    user = User.find(user_id)
    study.users << user
    study.save
    redirect_back fallback_location:show_study_url(study_id)
  end
  
  def delete_user
    study_id = params[:id]
    user_id = params[:user_id]
    study = Study.find(study_id)
    user = User.find(user_id)
    study.users.delete(user)
    study.save

    redirect_back fallback_location:show_study_url(study_id)
  end

  def add_course
    course_id=params[:course_id]
    study_id=params[:study_id]
    group_number=params[:group_number]    
    association = StudyCourse.create(study_id:study_id, course_id: course_id,group:group_number)

    redirect_back fallback_location:show_study_url(study_id)
  end

  def delete_course_group
    study_id = params[:study_id]
    study_course_id = params[:study_course_id]
    StudyCourse.find(study_course_id).delete()

    redirect_back fallback_location:show_study_url(study_id)
  end

  def update_study_course
    study_id = params[:study_id]
    study_course_id = params[:study_course_id]
    group_number = params[:group]
    StudyCourse.find(study_course_id).update(group:group_number)
    redirect_back fallback_location:show_study_url(study_id)
  end

end
