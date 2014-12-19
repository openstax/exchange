class CreatePeerGradingActivities < ActiveRecord::Migration
  def change
    create_table :peer_grading_activities do |t|
      t.activity
      t.decimal :correctness
      t.string :grade
      t.text :feedback

      t.timestamps null: false
    end

    add_activity_indices :peer_grading_activities
  end
end
