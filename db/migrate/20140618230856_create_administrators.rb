class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.user

      t.timestamps
    end
  end
end
