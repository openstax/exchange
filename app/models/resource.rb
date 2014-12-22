class Resource < ActiveRecord::Base
  acts_as_eventful
  acts_as_active

  belongs_to :platform, inverse_of: :resources

  validates :url, presence: true, uniqueness: true

  def http_url
    UrlProtocolConverter.to_http(url)
  end

  def https_url
    UrlProtocolConverter.to_https(url)
  end
end
