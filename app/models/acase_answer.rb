class AcaseAnswer < ApplicationRecord
  belongs_to :ace_evaluation
  belongs_to :acase
  belongs_to :evaluation
end
