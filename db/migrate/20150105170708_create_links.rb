class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :resource, null: false
      t.string :href, null: false
      t.string :rel, null: false

      t.timestamps null: false
    end

    add_index :links, [:href, :rel], unique: true
    add_index :links, :resource_id
  end
end
