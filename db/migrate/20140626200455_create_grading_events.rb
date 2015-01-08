class CreateGradingEvents < ActiveRecord::Migration
  def change
    create_table :grading_events do |t|
      t.references :task, null: false
      t.string :grader, null: false
      t.string :grade, null: false
      t.text :feedback

      t.timestamps null: false
    end

    add_index :grading_events, :task_id
    add_index :grading_events, :grader
  end
end
