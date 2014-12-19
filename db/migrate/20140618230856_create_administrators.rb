class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.user

      t.timestamps null: false
    end

    add_user_indices :administrators
  end
end
