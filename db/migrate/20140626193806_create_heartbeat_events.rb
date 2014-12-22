class CreateHeartbeatEvents < ActiveRecord::Migration
  def change
    create_table :heartbeat_events do |t|
      t.event
      t.boolean :active, null: false

      t.timestamps null: false
    end

    add_event_indices :heartbeat_events
  end
end
