class CreateInputEvents < ActiveRecord::Migration
  def change
    create_table :input_events do |t|
      t.event
      t.string :object
      t.string :action_type
      t.string :input_type
      t.text :input

      t.timestamps
    end

    add_event_index :input_events
    add_index :input_events, :object
    add_index :input_events, :action_type
    add_index :input_events, :input_type
  end
end
