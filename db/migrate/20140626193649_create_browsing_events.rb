class CreateBrowsingEvents < ActiveRecord::Migration
  def change
    create_table :browsing_events do |t|
      t.string :referer

      t.timestamps
    end
  end
end
