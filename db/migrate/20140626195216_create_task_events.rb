class CreateTaskEvents < ActiveRecord::Migration
  def change
    create_table :task_events do |t|
      t.event
      t.integer :number
      t.uuid :assigner_id
      t.string :assigner_type
      t.datetime :due_date
      t.boolean :is_complete

      t.timestamps
    end
  end
end
