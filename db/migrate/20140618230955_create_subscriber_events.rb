class CreateSubscriberEvents < ActiveRecord::Migration
  def change
    create_table :subscriber_events do |t|
      t.integer :subscriber_id
      t.integer :event_id
      t.boolean :read

      t.timestamps
    end

    add_index :subscriber_events, [:event_id, :subscriber_id], unique: true
    add_index :subscriber_events, [:subscriber_id, :read]
  end
end
