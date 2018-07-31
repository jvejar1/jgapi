class ItemAnswer < ApplicationRecord
  belongs_to :evaluation
  belongs_to :item
end
