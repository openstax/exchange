class CreateFeedbackActivities < ActiveRecord::Migration
  def change
    create_table :feedback_activities do |t|
      t.activity
      t.boolean :correct, null: false
      t.string :grade
      t.text :feedback, null: false, default: ''

      t.timestamps
    end

    add_activity_index :feedback_activities
    add_index :feedback_activities, :grade
  end
end
