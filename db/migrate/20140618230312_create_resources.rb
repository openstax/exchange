class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :reference, null: false
      t.integer :platform_id

      t.timestamps
    end

    add_index :resources, [:reference, :platform_id], unique: true
    add_index :resources, :platform_id
  end
end
