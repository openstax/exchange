class CreateCommunicationActivities < ActiveRecord::Migration
  def change
    create_table :communication_activities do |t|
      t.activity
      t.text :subject, null: false

      t.timestamps null: false
    end

    add_activity_indices :communication_activities
  end
end
