class CreateMessageEvents < ActiveRecord::Migration
  def change
    create_table :message_events do |t|
      t.event
      t.text :subject, null: false
      t.text :to
      t.text :cc
      t.text :bcc
      t.text :body

      t.timestamps null: false
    end

    add_event_indices :message_events
  end
end
