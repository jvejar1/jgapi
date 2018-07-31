class WreactionQuestionsController < ApplicationController
  before_action :set_wreaction_question, only: [:show, :edit, :update, :destroy]

  # GET /wreaction_questions
  # GET /wreaction_questions.json
  def index
    @wreaction_questions = WreactionQuestion.all
  end

  # GET /wreaction_questions/1
  # GET /wreaction_questions/1.json
  def show
  end

  # GET /wreaction_questions/new
  def new
    @wreaction_question = WreactionQuestion.new
  end

  # GET /wreaction_questions/1/edit
  def edit
  end

  # POST /wreaction_questions
  # POST /wreaction_questions.json
  def create
    @wreaction_question = WreactionQuestion.new(wreaction_question_params)

    respond_to do |format|
      if @wreaction_question.save
        format.html { redirect_to @wreaction_question, notice: 'Wreaction question was successfully created.' }
        format.json { render :show, status: :created, location: @wreaction_question }
      else
        format.html { render :new }
        format.json { render json: @wreaction_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wreaction_questions/1
  # PATCH/PUT /wreaction_questions/1.json
  def update
    respond_to do |format|
      if @wreaction_question.update(wreaction_question_params)
        format.html { redirect_to @wreaction_question, notice: 'Wreaction question was successfully updated.' }
        format.json { render :show, status: :ok, location: @wreaction_question }
      else
        format.html { render :edit }
        format.json { render json: @wreaction_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wreaction_questions/1
  # DELETE /wreaction_questions/1.json
  def destroy
    @wreaction_question.destroy
    respond_to do |format|
      format.html { redirect_to wreaction_questions_url, notice: 'Wreaction question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wreaction_question
      @wreaction_question = WreactionQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wreaction_question_params
      params.require(:wreaction_question).permit(:multimedia_id)
    end
end
