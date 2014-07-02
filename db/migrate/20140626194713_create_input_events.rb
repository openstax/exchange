class CreateInputEvents < ActiveRecord::Migration
  def change
    create_table :input_events do |t|
      t.event
      t.string :object
      t.string :category
      t.string :input_type
      t.text :value

      t.timestamps
    end

    add_event_index :input_events
    add_index :input_events, :object
    add_index :input_events, :category
    add_index :input_events, :input_type
  end
end
