class CorsisController < ApplicationController
  before_action :set_corsi, only: [:show, :edit, :update, :destroy]

  # GET /corsis
  # GET /corsis.json
  def index
    @corsis = Corsi.all
  end


  # GET /corsis/1
  # GET /corsis/1.json
  def show
  end

  # GET /corsis/new
  def new
    @corsi = Corsi.new
  end

  # GET /corsis/1/edit
  def edit
  end

  # POST /corsis
  # POST /corsis.json
  def create
    @corsi = Corsi.new(corsi_params)

    respond_to do |format|
      if @corsi.save
        format.html { redirect_to @corsi, notice: 'Corsi was successfully created.' }
        format.json { render :show, status: :created, location: @corsi }
      else
        format.html { render :new }
        format.json { render json: @corsi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corsis/1
  # PATCH/PUT /corsis/1.json
  def update
    respond_to do |format|
      if @corsi.update(corsi_params)
        format.html { redirect_to @corsi, notice: 'Corsi was successfully updated.' }
        format.json { render :show, status: :ok, location: @corsi }
      else
        format.html { render :edit }
        format.json { render json: @corsi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corsis/1
  # DELETE /corsis/1.json
  def destroy
    @corsi.destroy
    respond_to do |format|
      format.html { redirect_to corsis_url, notice: 'Corsi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corsi
      @corsi = Corsi.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corsi_params
      params.require(:corsi).permit(:version, :current)
    end
end
