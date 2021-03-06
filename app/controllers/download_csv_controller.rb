class DownloadCsvController < ApplicationController
  require 'csv_utilities'
  def index

    @moments = Moment.all
    @studies = Study.all

    @evaluations_count=Evaluation.count+CorsiEvaluation.count
    @ace_evaluations_count=Evaluation.where(ace_id:!nil).count
    @wally_evaluations_count=Evaluation.where(wally_id:!nil).count
    @corsi_evaluations_count=CorsiEvaluation.count
    @fonotest_evaluations_count=Evaluation.where(fonotest_id:!nil).count
    @hnf_evaluations_count=Evaluation.where(hnfset_id:!nil).count

    @instruments = Instrument.active

  end

  def instrument_report
    study = Study.find(params[:study_id])
    schools = School.find(params[:school_ids])
    desired_courses = schools.map{|s| s.courses}.flatten
    courses = study.courses & desired_courses
    students = courses.map{|c| c.students}.flatten
    instrument = Instrument.find(params[:instrument_id])
    items = instrument.items.where(item_type_id: 1..99)
    moments = Moment.find(params[:moment_ids])
    csv_str = generate_csv_str(instrument, items, study, moments, students)
    csv_filename = "#{instrument.name}.csv"
    send_data(csv_str, options={:filename=> csv_filename})
  end
  before_action :set_params, only: [:aces, :wally, :corsi, :hnf, :fonotest, :instrument]

  before_action :set_study, only: [:get_study_info]
  def aces
    file = generate_file(test: Ace.first, study: @study, evaluation_class: Evaluation, schools:@schools,moments: @moments)
    send_data file, filename: "aces.csv"
  end

  def wally
    file = generate_file(test: Wally.first, study: @study, evaluation_class: Evaluation, schools:@schools,moments: @moments)
    send_data file, filename: "wally.csv"
  end

  def corsi
    file = generate_file(test: Corsi.first, study: @study, evaluation_class: CorsiEvaluation, schools: @schools,moments: @moments)
    send_data file, filename: "corsi.csv"
  end

  def hnf
    file = generate_file(test: Hnfset.first, study: @study, evaluation_class: Evaluation, schools: @schools, moments: @moments)
    send_data file, filename: "hearts_and_flowers.csv"
  end

  def fonotest
    file = generate_file(test: Fonotest.first, study: @study, evaluation_class: Evaluation, schools: @schools,moments: @moments)
    send_data file, filename: "test_fonologico.csv"
  end

  def instrument

  end

  def get_study_info
    render json: {moments: @study.get_moments_with_name,
                  schools: @study.get_schools}
  end

  private

  def set_params
    @study = Study.find(JSON.parse(params[:study]).to_i)
    @schools = School.where(id: JSON.parse(params[:schools]))
    @moments = @study.get_moments.where(id: JSON.parse(params[:moments]))
  end

  def set_study
    puts "HOLA"
    study_id = params[:study]
    puts study_id.nil?
    @study = Study.find(JSON.parse(params[:study]).to_i)
  end

  def set_schools
    @schools = School.where(id: params[:schools])
    #ensure that the schools are in the study
  end

  def set_moments
    @moments = @study.get_moments.where(id: params[:moments])
  end
end
