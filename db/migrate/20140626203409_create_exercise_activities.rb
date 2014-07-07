class CreateExerciseActivities < ActiveRecord::Migration
  def change
    create_table :exercise_activities do |t|
      t.activity
      t.string :answer, null: false
      t.boolean :correct, null: false
      t.text :free_response, null: false, default: ''

      t.timestamps
    end

    add_activity_index :exercise_activities
    add_index :exercise_activities, :answer
  end
end
