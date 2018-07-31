class Afeeling < ApplicationRecord
  has_many :acase_feelings
  has_many :acases, through: :acase_feelings
end
