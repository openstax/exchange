class Resource < ActiveRecord::Base
  belongs_to :platform, inverse_of: :resources

  has_many :links, dependent: :destroy, inverse_of: :resource
  has_many :tasks, dependent: :destroy, inverse_of: :resource

  def url
    links_array = links.to_a
    canonical_links = links_array.select(&:is_canonical)
    links_array = canonical_links unless canonical_links.empty?

    links_array.sort_by{ |link| [-Link.sources[link.source], link.created_at] }.first.try :href
  end
end
