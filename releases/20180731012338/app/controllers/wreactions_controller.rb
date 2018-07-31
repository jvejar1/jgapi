class WreactionsController < ApplicationController
  before_action :set_wreaction, only: [:show, :edit, :update, :destroy]

  # GET /wreactions
  # GET /wreactions.json
  def index
    @wreactions = Wreaction.all
  end

  # GET /wreactions/1
  # GET /wreactions/1.json
  def show
  end

  # GET /wreactions/new
  def new
    @wreaction = Wreaction.new
  end

  # GET /wreactions/1/edit
  def edit
  end

  # POST /wreactions
  # POST /wreactions.json
  def create
    @wreaction = Wreaction.new(wreaction_params)

    respond_to do |format|
      if @wreaction.save
        format.html { redirect_to @wreaction, notice: 'Wreaction was successfully created.' }
        format.json { render :show, status: :created, location: @wreaction }
      else
        format.html { render :new }
        format.json { render json: @wreaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wreactions/1
  # PATCH/PUT /wreactions/1.json
  def update
    respond_to do |format|
      if @wreaction.update(wreaction_params)
        format.html { redirect_to @wreaction, notice: 'Wreaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @wreaction }
      else
        format.html { render :edit }
        format.json { render json: @wreaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wreactions/1
  # DELETE /wreactions/1.json
  def destroy
    @wreaction.destroy
    respond_to do |format|
      format.html { redirect_to wreactions_url, notice: 'Wreaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wreaction
      @wreaction = Wreaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wreaction_params
      params.require(:wreaction).permit(:text, :index)
    end
end
