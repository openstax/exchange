class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels, id: false do |t|
      t.binary :id, limit: 5, primary_key: true
      t.integer :person_id, null: false

      t.timestamps
    end

    add_index :labels, :person_id
  end
end
