class Item < ApplicationRecord
  scope :ordered, -> {order(order: :asc)}
  has_many :choices
  belongs_to :instrument
  belongs_to :picture
  accepts_nested_attributes_for :picture#, reject_if: lambda {|attributes| attributes['order'].blank?}

  belongs_to :item_type
  belongs_to :audio, optional:true
end
