class AddReportHeaderPrefixScoreToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :report_header_prefix_score, :text, :default => "item_score"
  end
end
