class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :resource_id, null: false
      t.string :reference, null: false

      t.timestamps
    end

    add_index :attempts, [:resource_id, :reference], unique: true
  end
end
