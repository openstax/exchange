class CreateInputEvents < ActiveRecord::Migration
  def change
    create_table :input_events do |t|
      t.event
      t.string :object
      t.string :input_type
      t.string :data_type
      t.text :data
      t.string :filename

      t.timestamps
    end

    add_event_index :input_events
    add_index :input_events, :object
    add_index :input_events, :input_type
    add_index :input_events, :data_type
    add_index :input_events, :filename
  end
end
