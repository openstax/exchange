class CreateExerciseActivities < ActiveRecord::Migration
  def change
    create_table :exercise_activities do |t|
      t.activity
      t.string :question_type
      t.string :answer
      t.decimal :correctness
      t.text :free_response

      t.timestamps null: false
    end

    add_activity_indices :exercise_activities
    add_index :exercise_activities, :question_type
  end
end
