class Csequence < ApplicationRecord
  has_many :corsi_csequences
  has_many :corsis, through: :corsi_csequences
  has_many :csquares
  default_scope { order(ordered: :desc) }

  def get_correct_sequence
    if self.ordered
      return self.csequence

    else
      seq_array=self.csequence.split("-")
      seq_array.reverse.join("-")

  end
    end
end
