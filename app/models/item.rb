class Item < ApplicationRecord
  belongs_to :audio, optional:true
end
