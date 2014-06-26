class CreateFeedbackActivities < ActiveRecord::Migration
  def change
    create_table :feedback_activities do |t|
      t.activity
      t.boolean :correct
      t.string :grade
      t.text :feedback

      t.timestamps
    end
  end
end
