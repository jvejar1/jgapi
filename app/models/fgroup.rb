class Fgroup < ApplicationRecord
  has_many :fgroup_items
  has_many :items, through: :fgroup_items
end
