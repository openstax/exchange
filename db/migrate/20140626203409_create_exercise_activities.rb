class CreateExerciseActivities < ActiveRecord::Migration
  def change
    create_table :exercise_activities do |t|
      t.activity
      t.string :answer_type
      t.string :answer
      t.decimal :correctness
      t.text :free_response

      t.timestamps null: false
    end

    add_activity_indices :exercise_activities
  end
end
