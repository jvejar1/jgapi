class Instrument < ApplicationRecord
  belongs_to :personalisation_of_instrument, class_name: 'Instrument', foreign_key: :personalisation_of_instrument_id
  has_many :personalisations, class_name: "Instrument", foreign_key: :personalisation_of_instrument_id
  has_many :items, -> { ordered }, class_name: 'Item'
  accepts_nested_attributes_for :items, reject_if: lambda {|attributes| attributes['order'].blank?}, allow_destroy: true
  has_many :constructs
  scope :usable, ->{where(deleted: false)}
end
