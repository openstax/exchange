class AddIsCanonicalToLinks < ActiveRecord::Migration
  def change
    add_column :links, :is_canonical, :boolean, null: false, default: false

    Link.where(source: Link.sources.values_at(:link_header, :link_tag))
        .update_all(is_canonical: true)
  end
end
