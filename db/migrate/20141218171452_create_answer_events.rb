class CreateAnswerEvents < ActiveRecord::Migration
  def change
    create_table :answer_events do |t|
      t.event
      t.string :answer_type, null: false
      t.string :answer, null: false

      t.timestamps null: false
    end

    add_event_indices :answer_events
  end
end
