class CreatePeerGradingActivities < ActiveRecord::Migration
  def change
    create_table :peer_grading_activities do |t|
      t.activity
      t.uuid :gradee_id
      t.string :grade
      t.text :feedback

      t.timestamps
    end
  end
end
