class WfeelingsController < ApplicationController
  before_action :set_wfeeling, only: [:show, :edit, :update, :destroy]

  # GET /wfeelings
  # GET /wfeelings.json
  def index
    @wfeelings = Wfeeling.all
  end

  # GET /wfeelings/1
  # GET /wfeelings/1.json
  def show
  end

  # GET /wfeelings/new
  def new
    @wfeeling = Wfeeling.new
  end

  # GET /wfeelings/1/edit
  def edit
  end

  # POST /wfeelings
  # POST /wfeelings.json
  def create
    @wfeeling = Wfeeling.new(wfeeling_params)

    respond_to do |format|
      if @wfeeling.save
        format.html { redirect_to @wfeeling, notice: 'Wfeeling was successfully created.' }
        format.json { render :show, status: :created, location: @wfeeling }
      else
        format.html { render :new }
        format.json { render json: @wfeeling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wfeelings/1
  # PATCH/PUT /wfeelings/1.json
  def update
    respond_to do |format|
      if @wfeeling.update(wfeeling_params)
        format.html { redirect_to @wfeeling, notice: 'Wfeeling was successfully updated.' }
        format.json { render :show, status: :ok, location: @wfeeling }
      else
        format.html { render :edit }
        format.json { render json: @wfeeling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wfeelings/1
  # DELETE /wfeelings/1.json
  def destroy
    @wfeeling.destroy
    respond_to do |format|
      format.html { redirect_to wfeelings_url, notice: 'Wfeeling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wfeeling
      @wfeeling = Wfeeling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wfeeling_params
      params.require(:wfeeling).permit(:text, :index)
    end
end
