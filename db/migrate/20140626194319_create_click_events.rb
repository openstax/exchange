class CreateClickEvents < ActiveRecord::Migration
  def change
    create_table :click_events do |t|
      t.event
      t.string :href

      t.timestamps null: false
    end

    add_event_indices :click_events
    add_index :click_events, :href
  end
end
