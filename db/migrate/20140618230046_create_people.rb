class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :label
      t.text :superseded_labels

      t.timestamps
    end
  end
end
