class RegenerateActivityTaskIdIndices < ActiveRecord::Migration
  def change
    remove_index :exercise_activities, :task_id
    remove_index :feedback_activities, :task_id
    remove_index :interactive_activities, :task_id
    remove_index :peer_grading_activities, :task_id
    remove_index :reading_activities, :task_id

    add_index :exercise_activities, :task_id, unique: true
    add_index :feedback_activities, :task_id, unique: true
    add_index :interactive_activities, :task_id, unique: true
    add_index :peer_grading_activities, :task_id, unique: true
    add_index :reading_activities, :task_id, unique: true
  end
end
