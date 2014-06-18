class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.integer :account_id

      t.timestamps
    end
  end
end
