class CreateApiKeys < ActiveRecord::Migration
  def self.up
    create_table :api_keys do |t|
      t.string :access_token
      t.timestamps
    end

    add_index :api_keys, :access_token, :unique => true
  end

  def self.down
    drop_table :api_keys
  end
end
