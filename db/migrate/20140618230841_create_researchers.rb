class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.user

      t.timestamps
    end
  end
end
