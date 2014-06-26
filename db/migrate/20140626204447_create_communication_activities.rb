class CreateCommunicationActivities < ActiveRecord::Migration
  def change
    create_table :communication_activities do |t|
      t.activity
      t.text :to
      t.text :cc
      t.text :bcc
      t.text :subject
      t.text :body

      t.timestamps
    end
  end
end
