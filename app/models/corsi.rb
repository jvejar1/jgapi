class Corsi < ApplicationRecord
  has_many :corsi_csequences
  has_many :csequences, through: :corsi_csequences
  has_many :corsi_evaluations
  has_many :evaluations

  def get_evaluations
    self.corsi_evaluations
  end

  def evaluations
    self.corsi_evaluations
  end

  def get_csequence_header(corsi_csequence_join_record, index)
    header = 'corsi'
    if corsi_csequence_join_record.csequence.ordered
      header += '_ordered'
    else
      header +='_reversed'
    end
    if corsi_csequence_join_record.example
      header += '_example'
    end

    header += '_' + index
    header
  end

  def get_sequence_header(sequence, index)
    header = 'corsi'
    if sequence.ordered
      header += '_ordered'
    else
      header +='_reverse'
    end
    if is_example(sequence)
      header += '_example'
    end
    header += '_' + index.to_s
    header
  end

  def is_example(csequence)
    self.corsi_csequences.where(csequence_id: csequence.id).first.example
  end

  def get_ordered_sequences
    self.csequences.where(ordered: true)
  end

  def get_reversed_sequences
    self.csequences.where(ordered: false)
  end

  def get_sequences(is_ordered, is_example)
    result = self.corsi_csequences.where(example: is_example).select do |corsi_csequence_join|
      corsi_csequence_join.csequence.ordered == is_ordered
    end
    result.collect{|corsi_csequence_join| corsi_csequence_join.csequence}
  end

  def get_all_sequences
    self.csequences.order(created_at: :asc)
  end

  def get_ordered_sequences
    joined_csequence_ids = self.corsi_csequences.collect{|corsi_csequence| corsi_csequence.csequence_id}
    self.get_all_sequences.where(ordered:true, id:joined_csequence_ids)
  end

  def get_reversed_sequences
    joined_csequence_ids = self.corsi_csequences.collect{|corsi_csequence| corsi_csequence.csequence_id}
    self.get_all_sequences.where(ordered:false, id:joined_csequence_ids)
  end


  def get_headers(moment_index)
    moment_index = moment_index.to_s
    headers = []
    headers << 'corsi_total_'+moment_index
    headers << 'ordered_tries_' + moment_index
    headers << 'reversed_tries_' + moment_index

    self.get_all_sequences.each_with_index do |sequence, index|
      headers << get_sequence_header(sequence, index+1) + '_'+ moment_index
      headers << 'answer'
    end

    return headers
  end

  def get_total_score(answers)
    answers.reduce(0){ |sum, answer| sum + get_score(answer)}
  end

  def get_score(answer)
    return answer.score
  end

  def get_answers(evaluation)
    evaluation.csequence_answers
  end

  def get_selections_and_scores(evaluation)
    results = []
    results << get_total_score(get_answers(evaluation))
    results << evaluation.ordered_practice_tries
    results << evaluation.reversed_practice_tries
    self.get_all_sequences.each do |csequence|
      answer = evaluation.csequence_answers.where(csequence: csequence).first
      results.concat( get_score_and_answer_string(answer))
    end
    results
  end

  def get_score_and_answer_string(answer)
    if answer.nil?
      [0, '']
    else
      [get_score(answer), answer.answer_string]
    end
  end

end
