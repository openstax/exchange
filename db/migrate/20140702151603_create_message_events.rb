class CreateMessageEvents < ActiveRecord::Migration
  def change
    create_table :message_events do |t|
      t.event
      t.string :message_uid, null: false
      t.integer :replied_id
      t.text :to, null: false, default: ''
      t.text :cc, null: false, default: ''
      t.text :bcc, null: false, default: ''
      t.text :subject, null: false, default: ''
      t.text :body, null: false, default: ''

      t.timestamps
    end

    add_event_index :message_events
    add_index :message_events, :message_uid, unique: true
    add_index :message_events, :replied_id
  end
end
