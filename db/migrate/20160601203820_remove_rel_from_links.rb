class RemoveRelFromLinks < ActiveRecord::Migration
  def up
    add_column :links, :source, :integer, null: false, default: 0

    Link.where(rel: 'canonical').update_all(source: Link.sources[:link_tag])
    Link.where(rel: 'alternate').update_all(source: Link.sources[:other])

    remove_index :links, column: [:href, :rel]

    remove_column :links, :rel

    add_index :links, :href, unique: true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
