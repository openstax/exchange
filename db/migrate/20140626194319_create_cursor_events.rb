class CreateCursorEvents < ActiveRecord::Migration
  def change
    create_table :cursor_events do |t|
      t.event
      t.string :object
      t.integer :x_position
      t.integer :y_position
      t.boolean :clicked

      t.timestamps
    end

    add_event_index :cursor_events
    add_index :cursor_events, :object
    add_index :cursor_events, :x_position
    add_index :cursor_events, :y_position
  end
end
