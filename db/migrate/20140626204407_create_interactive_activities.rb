class CreateInteractiveActivities < ActiveRecord::Migration
  def change
    create_table :interactive_activities do |t|
      t.activity
      t.text :progress

      t.timestamps
    end
  end
end
