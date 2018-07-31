class Hnfset < ApplicationRecord
  has_many :hnfset_hnftests
  has_many :hnftests, through: :hnfset_hnftests
  has_many :evaluations
end
