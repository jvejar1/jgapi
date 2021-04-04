class AddReportHeaderPrefixChoiceTextToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :report_header_prefix_choice_text, :string, default: 'selected_choice_text'
  end
end
