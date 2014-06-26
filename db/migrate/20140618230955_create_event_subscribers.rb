class CreateEventSubscribers < ActiveRecord::Migration
  def change
    create_table :event_subscribers do |t|
      t.integer :event_id
      t.integer :subscriber_id
      t.boolean :read

      t.timestamps
    end

    add_index :event_subscribers, [:event_id, :subscriber_id], unique: true
    add_index :event_subscribers, [:subscriber_id, :read]
  end
end
