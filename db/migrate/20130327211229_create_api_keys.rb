class CreateApiKeys < ActiveRecord::Migration
  def self.up
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :exchanger_id
      t.timestamps
    end

    add_index :api_keys, :access_token, :unique => true
    add_index :api_keys, :exchanger_id
  end

  def self.down
    drop_table :api_keys
  end
end
