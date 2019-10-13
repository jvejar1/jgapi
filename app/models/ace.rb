class Ace < ApplicationRecord
  has_many :ace_acases
  has_many :acases,through: :ace_acases
  has_many :ace_evaluations
  has_many :evaluations
  def self.ANGRY
    1
  end
  def self.HAPPY
    2
  end
  def self.SAD
    3
  end

  def self.SCARED
    4
  end

  def get_evaluations
    self.evaluations
  end

  def get_void_results
    ['']*get_needed_results_count
  end

  def get_questions
    self.acases.order("created_at ASC")
  end
  def get_selections_and_scores(evaluation)
    row = []
    row << get_total_score(evaluation)
    acases=self.get_questions
    acases.each do |acase|
      answer=AcaseAnswer.find_by(acase:acase,evaluation:evaluation)
      row<<answer.score
      row<<answer.selected_feeling
    end
    row
  end

  def get_total_score(evaluation)
    total_score = 0
    acases=self.get_questions
    acases.each do |acase|
      answer=AcaseAnswer.find_by(acase:acase,evaluation:evaluation)
      total_score += get_score(answer)
    end
    total_score
  end

  def get_score(answer)
    if answer.selected_feeling == answer.acase.correct_feeling && !answer.acase.is_distractor
      return 1
    else
      return 0
    end
  end

  def get_headers(moment_index)
    headers = []
    headers << 'aces_total_'+moment_index.to_s
    self.acases.each_with_index do |acase, index|
      headers << 'aces_'+ (index+1).to_s+'_'+moment_index.to_s
      headers << 'aces_emotion_'+ (index+1).to_s+'_'+moment_index.to_s
    end
    return headers
  end

  def get_needed_results_count
    get_headers(nil).count
  end


end
