class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.user
      t.integer :application_id, null: false
      t.boolean :is_manager, null: false, default: false

      t.timestamps
    end

    add_user_index :agents
    add_index :agents, :application_id
  end
end
