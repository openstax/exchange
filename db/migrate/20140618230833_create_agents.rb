class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.user
      t.integer :application_id, null: false
      t.boolean :is_manager, null: false, default: false

      t.timestamps
    end

    add_index :agents, [:account_id, :application_id], unique: true
    add_index :agents, :disabled_at
  end
end
