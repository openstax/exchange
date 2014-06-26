class CreateHeartbeatEvents < ActiveRecord::Migration
  def change
    create_table :heartbeat_events do |t|
      t.event
      t.integer :scroll_position

      t.timestamps
    end

    add_event_index :heartbeat_events
    add_index :heartbeat_events, :scroll_position
  end
end
