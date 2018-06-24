class AcesController < ApplicationController
  before_action :set_ace, only: [:show, :edit, :update, :destroy]

  # GET /aces
  # GET /aces.json


  def get_all


    #TODO: get attributes

    aces=Ace.find_by(current:true)
    acases_ar=aces.acases
    aces=aces.as_json
    aces[:acases]=acases_ar
    json_response={fonotest:get_fonotest_current_data,hnf:get_hnf_current_data,corsi:get_corsi_current_data,ace:aces,wally:get_all_of_current_wally}
    render json: json_response.as_json

  end


  def get_fonotest_current_data
    fonotest=Fonotest.find_by(current:true)

    as=fonotest.fonotest_items
    fonotest=fonotest.as_json
    items=[]
    as.each do |a|
      instruction=a.instruction
      example=a.example
      item=a.item
      name=a.name
      item=item.as_json
      item[:example]=example
      item[:instruction]=instruction
      item[:name]=name
      items<<item
    end
    fonotest[:items]=items
    return fonotest
  end

  def get_hnf_current_data
    hnfset=Hnfset.find_by(current:true)

    if hnfset.nil?
      return nil
    end
    puts hnfset.hnftests
    hnfs=hnfset.hnftests


    hnfset=hnfset.as_json
    hnfset[:set]=[]
    hnfs.each do |hnf|

      sequence=hnf.hnftest_figures
      hnf=hnf.as_json
      hnf[:sequence]=sequence
      hnfset[:set].append(hnf)
    end
    return hnfset
  end
  def get_current_version
    aces=Ace.find_by(current:true)
    render json:aces
  end



  def get_all_of_current_wally
    json_response={}
    current_wally=Wally.find_by(current:true)
    if current_wally.nil?
      return nil
    end
    wsituations=current_wally.wsituations
    situations_list=[]
    current_wally=current_wally.as_json
    wsituations.each do |wsituation|
      json_situation=wsituation.as_json
      wreactions=wsituation.wreactions
      json_situation[:wreactions]=wreactions.as_json
      situations_list<<json_situation
      puts json_situation
    end
    current_wally[:feelings]=Wfeeling.all.as_json
    current_wally[:wsituations]=situations_list

    return current_wally

  end

  def get_current_test_data
    aces=Ace.find_by(current:true)
    puts aces


    acases_ar=aces.acases
    acases=[]
    acases_ar.each do |acase|

      image_url=acase.image.url


      afeelings=acase.afeelings
      acase=acase.as_json
      acase["image_path"]=image_url
      acase["feelings"]=afeelings


      acases<<acase
    end
    aces=aces.as_json
    aces[:acases]=acases

    json_response={corsi:get_corsi_current_data,ace:aces,wally:get_all_of_current_wally}
    render json: json_response.as_json

  end



  def get_corsi_current_data
    corsi=Corsi.find_by(current:true)
    if corsi.nil?
      return corsi.as_json
    else
      set=corsi.csequences
      set_list=[]
      set.each do |s|

        s_as_json=s.as_json
        s_as_json[:squares]=s.csquares
        s_as_json[:index]=CorsiCsequence.find_by(corsi:corsi,csequence:s).index
        set_list<<s_as_json
        puts "hola"
        puts CorsiCsequence.find_by(corsi:corsi,csequence:s).as_json
      end

      corsi=corsi.as_json
      corsi[:set]=set_list
      return corsi
    end
  end

  def index
    @aces = Ace.all
  end

  # GET /aces/1
  # GET /aces/1.json
  def show
  end

  # GET /aces/new
  def new
    @ace = Ace.new
  end

  # GET /aces/1/edit
  def edit
  end

  # POST /aces
  # POST /aces.json
  def create
    @ace = Ace.new(ace_params)

    respond_to do |format|
      if @ace.save
        format.html { redirect_to @ace, notice: 'Ace was successfully created.' }
        format.json { render :show, status: :created, location: @ace }
      else
        format.html { render :new }
        format.json { render json: @ace.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aces/1
  # PATCH/PUT /aces/1.json
  def update
    respond_to do |format|
      if @ace.update(ace_params)
        format.html { redirect_to @ace, notice: 'Ace was successfully updated.' }
        format.json { render :show, status: :ok, location: @ace }
      else
        format.html { render :edit }
        format.json { render json: @ace.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aces/1
  # DELETE /aces/1.json
  def destroy
    @ace.destroy
    respond_to do |format|
      format.html { redirect_to aces_url, notice: 'Ace was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ace
      @ace = Ace.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ace_params
      params.require(:ace).permit(:version, :current)
    end
end
