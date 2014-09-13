class CleanTables < ActiveRecord::Migration
  def change
    drop_table :ahoy_events
    drop_table :event_notifications
    drop_table :impressions
    drop_table :visits
  end
end
