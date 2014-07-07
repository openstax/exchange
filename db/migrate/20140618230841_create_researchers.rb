class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.user

      t.timestamps
    end

    add_user_index :researchers
  end
end
