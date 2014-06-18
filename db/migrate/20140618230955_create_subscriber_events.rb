class CreateSubscriberEvents < ActiveRecord::Migration
  def change
    create_table :subscriber_events do |t|
      t.integer :subscriber_id
      t.integer :event_id

      t.timestamps
    end
  end
end
