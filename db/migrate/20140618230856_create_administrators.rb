class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.integer :account_id

      t.timestamps
    end
  end
end
