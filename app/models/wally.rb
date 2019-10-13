class Wally < ApplicationRecord
  has_many :wally_evaluations
  has_many :situation_sets
  has_many :wsituations, :through => :situation_sets
  has_many :evaluations

  def self.feelings_by_number
      return {1=>"FELIZ",2=>"TRISTE",3=>"ENOJADO",4=>"SOLO BIEN"}
  end

  def self.HAPPY
    1
  end
  def self.SAD
    2
  end
  def self.ANGRY
    3
  end
  def self.ONLY_GOOD
    4
  end
  def self.PROSOCIAL
    1
  end
  def self.AGRESIVA
    2
  end
  def self.DESREGULADA
    3
  end
  def self.EVASIVA
    4
  end
  def self.get_info_rows
   rows=[["Sentimiento"+ self.HAPPY.to_s,"FELIZ","",""+ self.PROSOCIAL.to_s,"PROSOCIAL"],
         ["Sentimiento"+ self.SAD.to_s,"TRISTE","",""+ self.AGRESIVA.to_s,"AGRESIVO"],
         ["Sentimiento"+ self.ANGRY.to_s,"ENOJADO","",""+ self.DESREGULADA.to_s,"DESREGULADA"],
         ["Sentimiento"+ self.ONLY_GOOD.to_s,"SOLO BIEN","",""+ self.EVASIVA.to_s,"EVASIVA"]]
  end


  def get_evaluations
    self.evaluations
  end

  def get_void_results
    ['']*get_headers(nil).count
  end

  def get_selections_and_scores(evaluation)
    results = []

    wsituations = self.get_wsituations
    wsituations.each do |situation|
      answer = evaluation.wsituation_answers.where(wsituation_id: situation.id).first
      results << answer.wfeeling_answer
      results << answer.wreaction_answer
    end

    results
  end

  def get_wsituations
    self.wsituations.order("created_at ASC")
  end

  def get_headers(moment_index)
    headers = []
    self.get_wsituations.each_with_index do |wsituation, index|
      headers << 'wally_emotion_'+ (index+1).to_s+'_'+moment_index.to_s
      headers << 'wally_behavior_'+ (index+1).to_s+'_'+moment_index.to_s
    end
    return headers
  end

end
