class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :identifier, null: false
      t.references :resource, null: false
      t.string :trial, null: false
      t.datetime :due_at

      t.timestamps null: false
    end

    add_index :tasks, [:identifier_id, :resource_id, :trial], unique: true
    add_index :tasks, [:resource_id, :trial]
    add_index :tasks, :due_at
  end
end
