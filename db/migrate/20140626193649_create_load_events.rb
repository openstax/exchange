class CreateLoadEvents < ActiveRecord::Migration
  def change
    create_table :load_events do |t|
      t.references :task, null: false
      t.string :referer

      t.timestamps null: false
    end

    add_index :load_events, :task_id
    add_index :load_events, :referer
  end
end
