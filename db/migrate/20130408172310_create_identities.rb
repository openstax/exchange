class CreateIdentities < ActiveRecord::Migration
  def self.up
    create_table :identities do |t|
      t.string :value
      t.integer :person_id
      t.timestamps
    end

    add_index :identities, :value, :unique => true
  end

  def self.down
    drop_table :identities
  end
end
