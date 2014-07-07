class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :label, null: false
      t.integer :platform_id, null: false
      t.integer :superseder_id

      t.timestamps
    end

    add_index :people, :label, unique: true
    add_index :people, :platform_id
    add_index :people, :superseder_id
  end
end
