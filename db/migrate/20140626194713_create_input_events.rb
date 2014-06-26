class CreateInputEvents < ActiveRecord::Migration
  def change
    create_table :input_events do |t|
      t.event
      t.string :object
      t.string :input_type
      t.string :data_type
      t.text :data
      t.string :filename

      t.timestamps
    end
  end
end
