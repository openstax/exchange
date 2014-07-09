class CreatePageEvents < ActiveRecord::Migration
  def change
    create_table :page_events do |t|
      t.event
      t.string :referer
      t.string :to

      t.timestamps
    end

    add_event_index :page_events
    add_index :page_events, :referer
    add_index :page_events, :to
  end
end
