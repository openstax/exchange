class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :label, null: false
      t.integer :successor_id

      t.timestamps
    end

    add_index :people, :label, unique: true
    add_index :people, :successor_id
  end
end
