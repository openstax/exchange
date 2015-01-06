class CreateTaskingEvents < ActiveRecord::Migration
  def change
    create_table :tasking_events do |t|
      t.references :task, null: false
      t.string :tasker, null: false
      t.datetime :due_date

      t.timestamps null: false
    end

    add_index :tasking_events, :task_id
    add_index :tasking_events, :tasker
    add_index :tasking_events, :due_date
  end
end
