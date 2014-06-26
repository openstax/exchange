class CreateExerciseActivities < ActiveRecord::Migration
  def change
    create_table :exercise_activities do |t|
      t.activity
      t.string :answer
      t.boolean :correct
      t.text :free_response

      t.timestamps
    end
  end
end
