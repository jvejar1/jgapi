class Moment < ApplicationRecord
  belongs_to :study

  def study_name
    if self.study.nil?
      "*****Sin estudio asignado****"
    else
      self.study.name
    end

  end
end
