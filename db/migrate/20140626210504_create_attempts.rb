class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.referable

      t.timestamps
    end

    add_referable_index :attempts
  end
end
