class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.user

      t.timestamps
    end

    add_user_index :administrators
  end
end
