class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :label, null: false
      t.integer :superseder_id

      t.timestamps null: false
    end

    add_index :people, :label, unique: true
    add_index :people, :superseder_id
  end
end
