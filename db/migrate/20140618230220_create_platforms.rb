class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.integer :application_id, null: false

      t.timestamps
    end

    add_index :platforms, :application_id, :unique => true
  end
end
