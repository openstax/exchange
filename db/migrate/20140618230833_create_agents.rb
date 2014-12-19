class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.user(application_specific: true)
      t.boolean :is_manager, null: false, default: false

      t.timestamps null: false
    end

    add_user_indices :agents, application_specific: true
  end
end
