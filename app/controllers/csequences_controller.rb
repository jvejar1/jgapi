class CsequencesController < ApplicationController
  before_action :set_csequence, only: [:show, :edit, :update, :destroy]

  # GET /csequences
  # GET /csequences.json
  def index
    @csequences = Csequence.all
  end

  # GET /csequences/1
  # GET /csequences/1.json
  def show
  end

  # GET /csequences/new
  def new
    @csequence = Csequence.new
  end

  # GET /csequences/1/edit
  def edit
  end

  # POST /csequences
  # POST /csequences.json
  def create
    @csequence = Csequence.new(csequence_params)

    respond_to do |format|
      if @csequence.save
        format.html { redirect_to @csequence, notice: 'Csequence was successfully created.' }
        format.json { render :show, status: :created, location: @csequence }
      else
        format.html { render :new }
        format.json { render json: @csequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /csequences/1
  # PATCH/PUT /csequences/1.json
  def update
    respond_to do |format|
      if @csequence.update(csequence_params)
        format.html { redirect_to @csequence, notice: 'Csequence was successfully updated.' }
        format.json { render :show, status: :ok, location: @csequence }
      else
        format.html { render :edit }
        format.json { render json: @csequence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /csequences/1
  # DELETE /csequences/1.json
  def destroy
    @csequence.destroy
    respond_to do |format|
      format.html { redirect_to csequences_url, notice: 'Csequence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csequence
      @csequence = Csequence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def csequence_params
      params.require(:csequence).permit(:sequence)
    end
end
