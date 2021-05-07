class ParticipantsFilesController < ApplicationController
  before_action :set_participants_file, only: %i[ show edit update destroy ]

  skip_before_action :verify_authenticity_token

  # GET /participants_files or /participants_files.json
  def index
    @participants_files = ParticipantsFile.all
  end

  # GET /participants_files/1 or /participants_files/1.json
  def show
  end

  # GET /participants_files/new
  def new
    @participants_file = ParticipantsFile.new
  end

  # GET /participants_files/1/edit
  def edit
    @selectable_courses = Course.where(id: @participants_file.schools.map{|s| s.courses}.flatten.map{|c| c.id})
    @schools = @participants_file.schools
    @schools.each do |school|
      school.courses.each do |course|
        course.students.build()
        #course.student_courses.where(student_id:nil).first.update(course_id: nil)
      end
      school.courses.build(students:[])
    end

    @participants_file.schools.build(courses: [])
  end

  # POST /participants_files or /participants_files.json
  def create
    params =participants_file_params
    csv_file = params[:csv_file]
    params.delete("csv_file")
    @participants_file = ParticipantsFile.new(params)

    respond_to do |format|
      if @participants_file.save
        format.html { redirect_to @participants_file, notice: "Participants file was successfully created." }
        format.json { render :show, status: :created, location: @participants_file }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @participants_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants_files/1 or /participants_files/1.json
  def update
    params =participants_file_params
    csv_file = params[:csv_file]
    params.delete("csv_file")
    notice = []
    unless csv_file.nil?
      @csv_file=CSV.read(csv_file.path, headers:true)
      csvprocessor=CSVProcessor.new()
      student_inserter=StudentInserter.new()
      student_inserter.set_participants_file(@participants_file)
    
      csvprocessor.process(
      @csv_file,
      student_inserter,
      StudentInserter.required_fields_with_school_and_course,
      student_inserter.method(:insert_using_participants_file))      

      csvprocessor.report_str

      flash[:notice]= student_inserter.report_str
      notice << student_inserter.report_str
    end
    
    respond_to do |format|
      if @participants_file.update(params)
        format.html { 
          notice<< "Participants file was successfully updated."
          redirect_to @participants_file, notice: notice.join(". ")
        }
        format.json { render :show, status: :ok, location: @participants_file }
      else
        puts @participants_file.errors.to_json
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participants_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants_files/1 or /participants_files/1.json
  def destroy
    @participants_file.destroy
    respond_to do |format|
      format.html { redirect_to participants_files_url, notice: "Participants file was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participants_file
      @participants_file = ParticipantsFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def participants_file_params
      params.require(:participants_file).permit(
        :user_id,
        :year,
        :csv_file,
        schools_attributes:[
          :id,
          :name,
          courses_attributes:[
            :id,
            :name,
            students_attributes:[
              :id,
              :name,
              :last_name,
              :rut,
              :id_rut
            ]
            
          ]
        ]
      )
    end
end
