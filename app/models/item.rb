class Item < ApplicationRecord
  belongs_to :instrument
  belongs_to :picture
  belongs_to :item_type
  belongs_to :audio, optional:true
end
