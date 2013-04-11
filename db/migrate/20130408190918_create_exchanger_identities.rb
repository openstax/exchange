class CreateExchangerIdentities < ActiveRecord::Migration
  def change
    create_table :exchanger_identities do |t|
      t.integer :exchanger_id
      t.integer :identity_id
      t.boolean :can_read
      t.boolean :can_write

      t.timestamps
    end

    add_index :exchanger_identities, :exchanger_id
    add_index :exchanger_identities, :identity_id
  end
end
