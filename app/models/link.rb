class Link < ActiveRecord::Base
  belongs_to :resource, inverse_of: :links

  enum source: [ :unknown, :other, :location_header, :link_tag, :link_header ]

  validates :resource, presence: true
  validates :href, presence: true, uniqueness: true

  def to_http
    UrlProtocolConverter.convert(href, to: :http)
  end

  def to_https
    UrlProtocolConverter.convert(href, to: :https)
  end
end
