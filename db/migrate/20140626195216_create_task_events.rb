class CreateTaskEvents < ActiveRecord::Migration
  def change
    create_table :task_events do |t|
      t.event
      t.integer :number
      t.binary :assigner_id, limit: 16
      t.string :assigner_type
      t.datetime :due_date
      t.boolean :is_complete

      t.timestamps
    end

    add_event_index :task_events
    add_index :task_events, :number
    add_index :task_events, :assigner_id
    add_index :task_events, :assigner_type
    add_index :task_events, :due_date
  end
end
