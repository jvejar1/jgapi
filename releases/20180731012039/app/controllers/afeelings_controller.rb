class AfeelingsController < ApplicationController
  before_action :set_afeeling, only: [:show, :edit, :update, :destroy]

  # GET /afeelings
  # GET /afeelings.json
  def index
    @afeelings = Afeeling.all
  end

  # GET /afeelings/1
  # GET /afeelings/1.json
  def show
  end

  # GET /afeelings/new
  def new
    @afeeling = Afeeling.new
  end

  # GET /afeelings/1/edit
  def edit
  end

  # POST /afeelings
  # POST /afeelings.json
  def create
    @afeeling = Afeeling.new(afeeling_params)

    respond_to do |format|
      if @afeeling.save
        format.html { redirect_to @afeeling, notice: 'Afeeling was successfully created.' }
        format.json { render :show, status: :created, location: @afeeling }
      else
        format.html { render :new }
        format.json { render json: @afeeling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /afeelings/1
  # PATCH/PUT /afeelings/1.json
  def update
    respond_to do |format|
      if @afeeling.update(afeeling_params)
        format.html { redirect_to @afeeling, notice: 'Afeeling was successfully updated.' }
        format.json { render :show, status: :ok, location: @afeeling }
      else
        format.html { render :edit }
        format.json { render json: @afeeling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /afeelings/1
  # DELETE /afeelings/1.json
  def destroy
    @afeeling.destroy
    respond_to do |format|
      format.html { redirect_to afeelings_url, notice: 'Afeeling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_afeeling
      @afeeling = Afeeling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def afeeling_params
      params.require(:afeeling).permit(:index, :text)
    end
end
