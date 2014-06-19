class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.user
      t.integer :application_id, null: false
      t.boolean :is_manager, null: false, default: false

      t.timestamps
    end
  end
end
