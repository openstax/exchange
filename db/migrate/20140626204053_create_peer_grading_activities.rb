class CreatePeerGradingActivities < ActiveRecord::Migration
  def change
    create_table :peer_grading_activities do |t|
      t.activity
      t.binary :gradee_id, limit: 16, null: false
      t.string :grade, null: false
      t.text :feedback, null: false, default: ''

      t.timestamps
    end

    add_activity_index :peer_grading_activities
    add_index :peer_grading_activities, :gradee_id
    add_index :peer_grading_activities, :grade
  end
end
