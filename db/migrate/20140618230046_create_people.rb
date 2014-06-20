class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :label, null: false
      t.text :superseded_labels, null: false, default: ''

      t.timestamps
    end

    add_index :people, :label, :unique => true
  end
end
