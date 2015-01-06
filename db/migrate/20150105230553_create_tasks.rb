class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :person, null: false
      t.references :resource, null: false
      t.references :platform, null: false
      t.string :trial, null: false
      t.datetime :due_at

      t.timestamps null: false
    end

    add_index :tasks, [:person_id, :resource_id, :platform_id, :trial],
              name: "index_tasks_on_p_id_and_r_id_and_p_id_and_trial",
              unique: true
    add_index :tasks, [:resource_id, :platform_id, :trial]
    add_index :tasks, :platform_id
    add_index :tasks, :due_at
  end
end
