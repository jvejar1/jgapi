class Fonotest < ApplicationRecord
  has_many :fonotest_items
  has_many :items, through: :fonotest_items
  has_many :evaluations

  def get_evaluations
    self.evaluations
  end
end
