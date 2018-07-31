class AcasesController < ApplicationController
  before_action :set_acase, only: [:show, :edit, :update, :destroy]

  # GET /acases
  # GET /acases.json
  def index
    @acases = Acase.all
  end

  # GET /acases/1
  # GET /acases/1.json
  def show
  end

  # GET /acases/new
  def new
    @acase = Acase.new
  end

  # GET /acases/1/edit
  def edit
  end

  # POST /acases
  # POST /acases.json
  def create
    @acase = Acase.new(acase_params)

    respond_to do |format|
      if @acase.save
        format.html { redirect_to @acase, notice: 'Acase was successfully created.' }
        format.json { render :show, status: :created, location: @acase }
      else
        format.html { render :new }
        format.json { render json: @acase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acases/1
  # PATCH/PUT /acases/1.json
  def update
    respond_to do |format|
      if @acase.update(acase_params)
        format.html { redirect_to @acase, notice: 'Acase was successfully updated.' }
        format.json { render :show, status: :ok, location: @acase }
      else
        format.html { render :edit }
        format.json { render json: @acase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acases/1
  # DELETE /acases/1.json
  def destroy
    @acase.destroy
    respond_to do |format|
      format.html { redirect_to acases_url, notice: 'Acase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acase
      @acase = Acase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acase_params
      params.require(:acase).permit(:ace_id, :index,:image)
    end
end
