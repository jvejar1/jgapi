class Instrument < ApplicationRecord
  belongs_to :personalisation_of_instrument, class_name: 'Instrument', foreign_key: :personalisation_of_instrument_id
  has_many :personalisations, class_name: "Instrument", foreign_key: :personalisation_of_instrument_id
  has_many :items
end
