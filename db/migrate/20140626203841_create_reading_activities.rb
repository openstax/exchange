class CreateReadingActivities < ActiveRecord::Migration
  def change
    create_table :reading_activities do |t|
      t.activity

      t.timestamps null: false
    end

    add_activity_indices :reading_activities
  end
end
