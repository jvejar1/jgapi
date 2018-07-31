class School < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :students, through: :courses
  default_scope { order(name: :asc) }
end
