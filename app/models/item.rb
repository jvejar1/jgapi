class Item < ApplicationRecord
  scope :ordered, -> {order(order: :asc)}
  has_many :choices
  belongs_to :instrument
  belongs_to :picture
  accepts_nested_attributes_for :picture#, reject_if: lambda {|attributes| attributes['order'].blank?}

  belongs_to :item_type
  belongs_to :audio, optional:true

  def get_report_header_choice_value(appended_number)
    unless self.report_header_prefix_choice_value.nil?
        "#{self.report_header_prefix_choice_value}#{appended_number}"
    else
      "no_header_prefix_#{appended_number}"
    end
  end
  def reports_choice_value?
    if self.report_header_prefix_choice_value
      true
    else
      false
    end
  end
end
