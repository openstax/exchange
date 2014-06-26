class CreateCursorEvents < ActiveRecord::Migration
  def change
    create_table :cursor_events do |t|
      t.event
      t.string :object
      t.integer :x_position
      t.integer :y_position
      t.boolean :clicked

      t.timestamps
    end
  end
end
