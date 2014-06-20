class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :application_id, null: false
      t.text :base_api_uri, null: false

      t.timestamps
    end

    add_index :subscribers, :application_id, :unique => true
  end
end
