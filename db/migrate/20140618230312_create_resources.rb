class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :platform_id
      t.string :reference

      t.timestamps
    end
  end
end
