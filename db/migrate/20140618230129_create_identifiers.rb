class CreateIdentifiers < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.integer :person_id, null: false
      t.integer :platform_id, null: false
      t.string :value, null: false

      t.timestamps
    end

    add_index :identifiers, :value, :unique => true
    add_index :identifiers, :person_id
    add_index :identifiers, :platform_id
  end
end
