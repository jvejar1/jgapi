class CsequenceAnswer < ApplicationRecord
  belongs_to :corsi_evaluation
  belongs_to :csequence
  belongs_to :evaluation
end
