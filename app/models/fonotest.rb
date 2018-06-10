class Fonotest < ApplicationRecord
  has_many :fonotest_fgroups
  has_many :fgroups, through: :fonotest_fgroups
  accepts_nested_attributes_for :fonotest_fgroups

end
