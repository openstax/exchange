class CreateTaskEvents < ActiveRecord::Migration
  def change
    create_table :task_events do |t|
      t.event
      t.integer :number, null: false
      t.integer :assigner_id
      t.datetime :due_date
      t.string :status

      t.timestamps
    end

    add_event_index :task_events
    add_index :task_events, [:number, :platform_id]
    add_index :task_events, :assigner_id
    add_index :task_events, :due_date
    add_index :task_events, :status
  end
end
