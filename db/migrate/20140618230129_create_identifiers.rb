class CreateIdentifiers < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.string :value, null: false
      t.integer :person_id, null: false
      t.integer :platform_id, null: false

      t.timestamps
    end

    add_index :identifiers, :value, unique: true
    add_index :identifiers, [:person_id, :platform_id], unique: true
    add_index :identifiers, :platform_id
  end
end
