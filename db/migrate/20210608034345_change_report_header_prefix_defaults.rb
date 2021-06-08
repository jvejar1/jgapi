class ChangeReportHeaderPrefixDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :report_header_prefix_score, :string, :default=>nil
    change_column :items, :report_header_prefix_choice_text, :string, :default=>nil
    change_column :items, :report_header_prefix_choice_value, :string, :default=>nil
  end
end
