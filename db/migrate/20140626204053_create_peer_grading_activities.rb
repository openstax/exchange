class CreatePeerGradingActivities < ActiveRecord::Migration
  def change
    create_table :peer_grading_activities do |t|
      t.activity
      t.references :grader, null: false
      t.string :grade
      t.text :feedback

      t.timestamps null: false
    end

    add_activity_indices :peer_grading_activities
    add_index :peer_grading_activities, :grader_id
  end
end
