class CreateExchangers < ActiveRecord::Migration
  def change
    create_table :exchangers do |t|

      t.timestamps
    end
  end
end
