class Construct < ApplicationRecord
  belongs_to :calculation_type
  belongs_to :instrument
  has_many :item_constructs
  has_many :items, through: :item_constructs

end
