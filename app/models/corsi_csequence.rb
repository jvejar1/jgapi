class CorsiCsequence < ApplicationRecord
  belongs_to :corsi
  belongs_to :csequence
  default_scope { order(index: :asc) }
end
