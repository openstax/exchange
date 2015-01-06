class CreateHeartbeatEvents < ActiveRecord::Migration
  def change
    create_table :heartbeat_events do |t|
      t.references :task, null: false
      t.boolean :active

      t.timestamps null: false
    end

    add_index :heartbeat_events, :task_id
  end
end
