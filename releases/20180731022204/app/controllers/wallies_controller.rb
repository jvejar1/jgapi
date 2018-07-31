class WalliesController < ApplicationController
  before_action :set_wally, only: [:show, :edit, :update, :destroy]

  # GET /wallies
  # GET /wallies.json
  def index
    @wallies = Wally.all
  end


  def get_all_of_current
    json_response={}
    current_wally=Wally.find_by(current:true)
    wsituations=current_wally.wsituations
    situations_list=[]
    current_wally=current_wally.as_json

    wsituations.each do |wsituation|
      json_situation=wsituation.as_json
      wfquestion=wsituation.wfeeling_question
      wrquestion=wsituation.wreaction_question
      puts wfquestion
      json_situation[:wfeeling_question]=wfquestion.as_json

      json_situation[:wreaction_question]=wfquestion.as_json
      situations_list<<json_situation

      puts json_situation
    end
    current_wally[:wsituations]=situations_list
    render :json=>{wally:current_wally}

  end
  # GET /wallies/1
  # GET /wallies/1.json
  def show
  end

  # GET /wallies/new
  def new
    @wally = Wally.new
  end

  # GET /wallies/1/edit
  def edit
  end

  # POST /wallies
  # POST /wallies.json
  def create
    @wally = Wally.new(wally_params)

    respond_to do |format|
      if @wally.save
        format.html { redirect_to @wally, notice: 'Wally was successfully created.' }
        format.json { render :show, status: :created, location: @wally }
      else
        format.html { render :new }
        format.json { render json: @wally.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallies/1
  # PATCH/PUT /wallies/1.json
  def update
    respond_to do |format|
      if @wally.update(wally_params)
        format.html { redirect_to @wally, notice: 'Wally was successfully updated.' }
        format.json { render :show, status: :ok, location: @wally }
      else
        format.html { render :edit }
        format.json { render json: @wally.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallies/1
  # DELETE /wallies/1.json
  def destroy
    @wally.destroy
    respond_to do |format|
      format.html { redirect_to wallies_url, notice: 'Wally was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wally
      @wally = Wally.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wally_params
      params.require(:wally).permit(:version, :description, :current)
    end
end
