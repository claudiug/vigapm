class CleanTables < ActiveRecord::Migration
  def change
    drop_table :ahoy_events if table_exists?(:ahoy_events)
    drop_table :event_notifications if table_exists?(:event_notifications)
    drop_table :impressions if table_exists?(:impressions)
    drop_table :visits if table_exists?(:visits)
  end
end
