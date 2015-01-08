class CreateLinkEvents < ActiveRecord::Migration
  def change
    create_table :link_events do |t|
      t.references :task, null: false
      t.string :href

      t.timestamps null: false
    end

    add_index :link_events, :task_id
    add_index :link_events, :href
  end
end
