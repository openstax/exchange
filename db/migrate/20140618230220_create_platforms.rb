class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.integer :application_id

      t.timestamps
    end
  end
end
