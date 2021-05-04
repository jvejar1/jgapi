class InstrumentsController < ApplicationController
  before_action :ensure_user_is_admin
  before_action :set_instrument, only: %i[ show edit update destroy ]
  # GET /instruments or /instruments.json
  def index
    @instruments = Instrument.active.all
  end

  # GET /instruments/1 or /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = Instrument.new
    1.times {
      @instrument.items.new(picture: Picture.new)
    }
  end

  # GET /instruments/1/edit
  def edit
    @instrument.items.each do |item|
      if item.picture.nil?
        item.update(picture: Picture.new)
      end  
    end
    @instrument.items.build(picture: Picture.new)
  end

  # POST /instruments or /instruments.json
  def create
    @instrument = Instrument.new(instrument_params)

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to @instrument, notice: "Instrument was successfully created." }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1 or /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to @instrument, notice: "Instrument was successfully updated." }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1 or /instruments/1.json
  def destroy
    @instrument.update(deleted:true)
    respond_to do |format|
      format.html { redirect_to instruments_url, notice: "Instrument was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instrument_params
      params.require(:instrument).permit(:name,:instruction,items_attributes:[:id,:order, :description, :_destroy, picture_attributes:[:id, :image]])
    end
end
