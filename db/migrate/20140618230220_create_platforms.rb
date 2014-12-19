class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.application

      t.timestamps null: false
    end

    add_application_index :platforms
  end
end
