class CreateGradingEvents < ActiveRecord::Migration
  def change
    create_table :grading_events do |t|
      t.event
      t.string :grader, null: false
      t.string :grade, null: false
      t.text :feedback

      t.timestamps null: false
    end

    add_event_indices :grading_events
    add_index :grading_events, :grader
  end
end
