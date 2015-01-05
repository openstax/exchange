class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.timestamps null: false
    end
  end
end
