class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :is_registered
      t.boolean :is_admin
      t.datetime :disabled_at
      t.integer :openstax_accounts_account_id

      t.timestamps
    end

    add_index :users, :openstax_accounts_account_id
    add_index :users, :is_admin
    add_index :users, :is_registered
  end
end
