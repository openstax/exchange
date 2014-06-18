class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.integer :account_id
      t.integer :application_id
      t.boolean :is_manager

      t.timestamps
    end
  end
end
