class AddReportHeaderPrefixChoiceValueToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :report_header_prefix_choice_value, :text, default: "item_choice_value"
  end
end
