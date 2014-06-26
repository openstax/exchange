class CreateInteractiveActivities < ActiveRecord::Migration
  def change
    create_table :interactive_activities do |t|
      t.activity
      t.text :progress, null: false, default: ''

      t.timestamps
    end

    add_activity_index :interactive_activities
  end
end
