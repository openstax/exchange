class CreateTaskingEvents < ActiveRecord::Migration
  def change
    create_table :tasking_events do |t|
      t.event
      t.string :tasker, null: false
      t.datetime :due_date

      t.timestamps null: false
    end

    add_event_indices :tasking_events
    add_index :tasking_events, :tasker
    add_index :tasking_events, :due_date
  end
end
