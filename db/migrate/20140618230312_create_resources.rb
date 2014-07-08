class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :platform_id, null: false
      t.string :reference, null: false

      t.timestamps
    end

    add_index :resources, [:reference, :platform_id], unique: true
    add_index :resources, :platform_id
  end
end
