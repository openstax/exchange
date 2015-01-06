class CreateUnloadEvents < ActiveRecord::Migration
  def change
    create_table :unload_events do |t|
      t.references :task, null: false
      t.string :destination

      t.timestamps null: false
    end

    add_index :unload_events, :task_id
    add_index :unload_events, :destination
  end
end
