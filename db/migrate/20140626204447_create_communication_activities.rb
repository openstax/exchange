class CreateCommunicationActivities < ActiveRecord::Migration
  def change
    create_table :communication_activities do |t|
      t.activity
      t.text :to, null: false
      t.text :cc, null: false, default: ''
      t.text :bcc, null: false, default: ''
      t.text :subject, null: false
      t.text :body, null: false, default: ''

      t.timestamps
    end

    add_activity_index :communication_activities
  end
end
