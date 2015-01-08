class CreateResearchers < ActiveRecord::Migration
  def change
    create_table :researchers do |t|
      t.user

      t.timestamps null: false
    end

    add_user_indices :researchers
  end
end
