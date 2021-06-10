class Choice < ApplicationRecord
  belongs_to :item
  belongs_to :parent, class_name: 'Choice', foreign_key: :parent_choice_id
  has_many :children, class_name: 'Choice', foreign_key: :parent_choice_id
  belongs_to :picture
  default_scope {order(order: :asc)}
end
