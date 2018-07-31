class WallyEvaluation < ApplicationRecord
  belongs_to :user
  belongs_to :wally
  belongs_to :student
end
