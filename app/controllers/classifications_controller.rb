class ClassificationsController < ApplicationController
  load  './lib/read_excel.rb'
  include ExcelUtil
  def index
    set_instrument
    @study_id = params[:study_id]
    study = Study.find(@study_id)

    @users = study.users
    @from = 10.day.ago.strftime("%FT%R")
    @until = 1.day.from_now.strftime("%FT%R")
  end

  def show
    set_instrument
    users = params[:users]
    users = User.where(id:[users])
    puts users
    date_from = nil
    begin
      date_from = params[:from]
      date_from = DateTime.parse(date_from)
    rescue ArgumentError => e
      date_from = 10.days.ago
    end
    date_until = nil
    begin
      date_until = params[:until]
      date_until = DateTime.parse(date_until)
    rescue ArgumentError => e
      date_until = DateTime.now.utc
    end

    file_path  = create_excel(@instrument.id, @instrument_second.id, users, date_from, date_until)
    send_file(file_path)
  end

  def create
    set_instrument
    uploaded_io = params[:picture]
    result = read_excel(uploaded_io.path(), [@instrument],nil)
    unless result[:errors_details].empty?
      text = result[:errors_details].join("; ")
      flash.alert = "Hubo los siguientes errores: #{text}"
    end

    n_processed_rows = result[:modified_rows]
    flash.notice = "#{n_processed_rows.to_s} filas procesadas exitosamente"
    redirect_to action: "index", study_id:@study.id
  end

  def set_instrument

    @study_id = params[:study_id]
    @study = Study.find(@study_id)
    @instrument = @study.instruments[0]
    @instrument_second = @study.instruments[1]
    puts @instrument.id
    puts @instrument_second.id

  end

end