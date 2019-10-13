class Hnfset < ApplicationRecord
  has_many :hnfset_hnftests
  has_many :hnftests, through: :hnfset_hnftests
  has_many :evaluations

  def get_evaluations
    self.evaluations
  end

  def get_headers(moment_index)
    moment_index = moment_index.to_s
    headers = []
    headers << 'hnf_total_'+moment_index
    self.hnftests.each do |test|
      headers<<"score_"+Hnftest.TEST_NAME_BY_NUMBER[test.hnf_type] + '_' + moment_index
      headers<<"time_seconds_"+ Hnftest.TEST_NAME_BY_NUMBER[test.hnf_type] + '_' + moment_index
    end
    headers<<"total_time" + '_' + moment_index
    headers
  end

  def get_selections_and_scores(evaluation)
    result = []
    result << get_total_score(evaluation)
    self.hnftests.each do |test|
      answer = evaluation.hnf_answers.where(hnftest:test).first
      result << answer.score
      result << answer.time_in_seconds
    end
    result << get_total_time(evaluation)
    result
  end

  def get_total_score(evaluation)
    total_score = 0
    self.hnftests.each do |test|
      answer = evaluation.hnf_answers.where(hnftest:test.id).first
      total_score += answer.score
    end
    total_score
  end

  def get_total_time(evaluation)
    total_time = 0
    self.hnftests.each do |test|
      answer = evaluation.hnf_answers.where(hnftest:test).first
      total_time += answer.time_in_seconds
    end
    total_time
  end

end
