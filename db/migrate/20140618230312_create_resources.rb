class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.referable

      t.timestamps
    end

    add_referable_index :resources
  end
end
