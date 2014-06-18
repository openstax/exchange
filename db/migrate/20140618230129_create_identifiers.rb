class CreateIdentifiers < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.integer :person_id
      t.integer :platform_id
      t.string :value

      t.timestamps
    end
  end
end
