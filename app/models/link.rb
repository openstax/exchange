class Link < ActiveRecord::Base
  belongs_to :resource, inverse_of: :links

  validates :rel, presence: true
  validates :href, presence: true, uniqueness: { scope: :rel }
  validate :same_resource

  def to_http
    UrlProtocolConverter.convert(href, to: :http)
  end

  def to_https
    UrlProtocolConverter.convert(href, to: :https)
  end

  protected

  def same_resource
    return if Link.where(href: href).all?{ |link| link.resource == resource }
    errors.add(:href, 'must be unique for each resource')
    false
  end
end
