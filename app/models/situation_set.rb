class SituationSet < ApplicationRecord
  belongs_to :wally
  belongs_to :wsituation
  default_scope { order(index: :asc) }
end
