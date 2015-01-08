class CreateIdentifiers < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.references :platform, null: false
      t.references :person, null: false
      t.string :research_label, null: false

      t.timestamps null: false
    end

    add_index :identifiers, :research_label, unique: true
    add_index :identifiers, [:person_id, :platform_id]
  end
end
