class CreateInputEvents < ActiveRecord::Migration
  def change
    create_table :input_events do |t|
      t.event
      t.string :object
      t.string :action
      t.string :data_type
      t.text :data

      t.timestamps
    end

    add_event_index :input_events
    add_index :input_events, :object
    add_index :input_events, :action
    add_index :input_events, :data_type
  end
end
