class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :openstax_accounts_account_id, null: false
      t.string :role, null: false
      t.datetime :disabled_at

      t.timestamps
    end

    add_index :users, :openstax_accounts_account_id, unique: true
    add_index :users, :role
  end
end
