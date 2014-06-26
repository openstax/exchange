class CreateReadingActivities < ActiveRecord::Migration
  def change
    create_table :reading_activities do |t|
      t.activity

      t.timestamps
    end
  end
end
