class CreateHeartbeatEvents < ActiveRecord::Migration
  def change
    create_table :heartbeat_events do |t|
      t.event
      t.integer :scroll_position

      t.timestamps
    end
  end
end
