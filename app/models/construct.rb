class Construct < ApplicationRecord
  belongs_to :calculation_type
  belongs_to :instrument
end
