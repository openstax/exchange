class CreateCursorEvents < ActiveRecord::Migration
  def change
    create_table :cursor_events do |t|
      t.event
      t.string :action, null: false
      t.string :href
      t.integer :x_position
      t.integer :y_position

      t.timestamps null: false
    end

    add_event_indices :cursor_events
    add_index :cursor_events, :action
    add_index :cursor_events, :href
  end
end
