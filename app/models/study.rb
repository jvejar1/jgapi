class Study < ApplicationRecord
  has_many :user_studies, dependent: :delete_all
  has_many :users, through: :user_studies
  has_many :study_instruments, dependent: :delete_all
  has_many :instruments, through: :study_instruments
  accepts_nested_attributes_for :study_instruments, reject_if: lambda {|attributes| attributes['instrument_id'].blank?}, allow_destroy: true

  has_many :moments, dependent: :delete_all
  has_many :study_courses, dependent: :delete_all
  has_many :courses, through: :study_courses

  validates :name, presence: true
  
  def get_baseline_moment
    self.moments.order(from: :asc).first
  end

  @@CONTROL = 0
  @@INTERVENTION = 1

  def self.CONTROL
    @@CONTROL
  end

  def self.INTERVENTION
    @@INTERVENTION
  end

  def get_moments_with_name
    moments =[]
    self.get_moments.each do |moment|
      moment_name = get_moment_name(moment)
      moment = moment.as_json
      moment[:name] = moment_name
      moments << moment
    end
    moments
  end

  def get_moment_name(moment)
    if moment == self.get_baseline_moment
      return 'baseline'
    else
      return 'follow_up_'+self.get_moments.index(moment).to_s
    end
  end

  def get_moment_index(moment)
    self.get_moments.index(moment)
  end

  def get_moments
    self.moments.order(from: :asc)
  end

  def get_schools
    self.courses.collect{|course| course.school}.uniq
  end

end
