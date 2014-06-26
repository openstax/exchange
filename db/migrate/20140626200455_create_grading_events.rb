class CreateGradingEvents < ActiveRecord::Migration
  def change
    create_table :grading_events do |t|
      t.event
      t.uuid :grader_id
      t.string :grader_type
      t.string :grade
      t.text :feedback

      t.timestamps
    end
  end
end
