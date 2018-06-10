class FonotestFgroup < ApplicationRecord
  belongs_to :fonotest
  belongs_to :fgroup
  default_scope ->{ order(index: :asc) }
end
