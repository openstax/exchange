class CreateFeedbackActivities < ActiveRecord::Migration
  def change
    create_table :feedback_activities do |t|
      t.activity
      t.string :grade

      t.timestamps null: false
    end

    add_activity_indices :feedback_activities
  end
end
