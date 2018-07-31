class WfeelingQuestionsController < ApplicationController
  before_action :set_wfeeling_question, only: [:show, :edit, :update, :destroy]

  # GET /wfeeling_questions
  # GET /wfeeling_questions.json
  def index
    @wfeeling_questions = WfeelingQuestion.all
  end

  # GET /wfeeling_questions/1
  # GET /wfeeling_questions/1.json
  def show
  end

  # GET /wfeeling_questions/new
  def new
    @wfeeling_question = WfeelingQuestion.new
  end

  # GET /wfeeling_questions/1/edit
  def edit
  end

  # POST /wfeeling_questions
  # POST /wfeeling_questions.json
  def create
    @wfeeling_question = WfeelingQuestion.new(wfeeling_question_params)

    respond_to do |format|
      if @wfeeling_question.save
        format.html { redirect_to @wfeeling_question, notice: 'Wfeeling question was successfully created.' }
        format.json { render :show, status: :created, location: @wfeeling_question }
      else
        format.html { render :new }
        format.json { render json: @wfeeling_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wfeeling_questions/1
  # PATCH/PUT /wfeeling_questions/1.json
  def update
    respond_to do |format|
      if @wfeeling_question.update(wfeeling_question_params)
        format.html { redirect_to @wfeeling_question, notice: 'Wfeeling question was successfully updated.' }
        format.json { render :show, status: :ok, location: @wfeeling_question }
      else
        format.html { render :edit }
        format.json { render json: @wfeeling_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wfeeling_questions/1
  # DELETE /wfeeling_questions/1.json
  def destroy
    @wfeeling_question.destroy
    respond_to do |format|
      format.html { redirect_to wfeeling_questions_url, notice: 'Wfeeling question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wfeeling_question
      @wfeeling_question = WfeelingQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wfeeling_question_params
      params.require(:wfeeling_question).permit(:multimedia_id)
    end
end
