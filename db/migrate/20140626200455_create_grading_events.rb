class CreateGradingEvents < ActiveRecord::Migration
  def change
    create_table :grading_events do |t|
      t.event
      t.string :grader_id
      t.string :grade
      t.text :feedback

      t.timestamps
    end

    add_event_index :grading_events
    add_index :grading_events, :grader_id
    add_index :grading_events, :grade
  end
end
