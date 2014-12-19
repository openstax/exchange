class CreateInputEvents < ActiveRecord::Migration
  def change
    create_table :input_events do |t|
      t.event
      t.string :input_type, null: false
      t.text :value

      t.timestamps null: false
    end

    add_event_indices :input_events
    add_index :input_events, :input_type
  end
end
