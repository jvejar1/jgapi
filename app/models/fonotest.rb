class Fonotest < ApplicationRecord
  has_many :fonotest_items
  has_many :items, through: :fonotest_items
  has_many :evaluations

  def get_headers(moment_index)
    headers = []
    headers << 'total_score_'+moment_index
    self.get_items.each do |fonotest_item_join|
      header_name=fonotest_item_join.name
      headers<<header_name+"_score_" + moment_index
      headers<<header_name+"_answer_" + moment_index
    end
    return headers
  end

  def get_selections_and_scores(evaluation)
    results = []
    results << get_total_score(evaluation.item_answers)
    self.get_items.each do |item|
      answer = evaluation.item_answers.where(item: item).first
      begin
        results << get_score(answer)
        results << answer.answer_string
      rescue NoMethodError
        results << 0
        results << ''
      end
    end
    results
  end

  def get_items
    self.fonotest_items.order(created_at: :asc)
  end

  def get_total_score(answers)
    total_score = 0
    answers.each do |answer|
      total_score += get_score(answer)
    end
    total_score
  end

  def get_score(answer)
    return answer.score
  end

end
