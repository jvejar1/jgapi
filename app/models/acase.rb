class Acase < ApplicationRecord
  belongs_to :picture
  has_many :ace_acases
  has_many :aces,through: :ace_acases
  has_many :acase_correct_feelings
  has_many :acase_answers

  def is_distractor
    return self.distractor
  end
end
