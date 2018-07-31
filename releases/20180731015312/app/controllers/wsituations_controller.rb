class WsituationsController < ApplicationController
  before_action :set_wsituation, only: [:show, :edit, :update, :destroy]

  # GET /wsituations
  # GET /wsituations.json
  def index
    @wsituations = Wsituation.all
  end

  # GET /wsituations/1
  # GET /wsituations/1.json
  def show
  end

  # GET /wsituations/new
  def new
    @wsituation = Wsituation.new
  end

  # GET /wsituations/1/edit
  def edit
  end

  # POST /wsituations
  # POST /wsituations.json
  def create
    @wsituation = Wsituation.new(wsituation_params)

    respond_to do |format|
      if @wsituation.save
        format.html { redirect_to @wsituation, notice: 'Wsituation was successfully created.' }
        format.json { render :show, status: :created, location: @wsituation }
      else
        format.html { render :new }
        format.json { render json: @wsituation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wsituations/1
  # PATCH/PUT /wsituations/1.json
  def update
    respond_to do |format|
      if @wsituation.update(wsituation_params)
        format.html { redirect_to @wsituation, notice: 'Wsituation was successfully updated.' }
        format.json { render :show, status: :ok, location: @wsituation }
      else
        format.html { render :edit }
        format.json { render json: @wsituation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wsituations/1
  # DELETE /wsituations/1.json
  def destroy
    @wsituation.destroy
    respond_to do |format|
      format.html { redirect_to wsituations_url, notice: 'Wsituation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wsituation
      @wsituation = Wsituation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wsituation_params
      params.require(:wsituation).permit(:multimedia_id, :description, :wfeeling_question_id, :wreaction_question_id)
    end
end
