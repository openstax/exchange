class CreateEventSubscribers < ActiveRecord::Migration
  def change
    create_table :event_subscribers do |t|
      t.integer :event_id, null: false
      t.integer :subscriber_id, null: false
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end

    add_index :event_subscribers, [:event_id, :subscriber_id], unique: true
    add_index :event_subscribers, [:subscriber_id, :read]
  end
end
