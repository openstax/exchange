class CreateBrowsingEvents < ActiveRecord::Migration
  def change
    create_table :browsing_events do |t|
      t.event
      t.string :referer

      t.timestamps
    end

    add_index :browsing_events, :referer
  end
end
