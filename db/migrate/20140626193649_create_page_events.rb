class CreatePageEvents < ActiveRecord::Migration
  def change
    create_table :page_events do |t|
      t.event
      t.string :from
      t.string :to

      t.timestamps null: false
    end

    add_event_indices :page_events
    add_index :page_events, :from
    add_index :page_events, :to
  end
end
