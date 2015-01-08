class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.application

      t.timestamps null: false
    end

    add_application_index :subscribers
  end
end
