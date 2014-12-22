class UrlProtocolConverter

  cattr_accessor :converters
  self.converters = {}

  def self.register(protocol, converter)
    converters[protocol] = converter
  end

  def self.to_http(url)
    url ||= ''
    protocol = URI(url).scheme
    converters[protocol].try(:to_http, url) || url.gsub(protocol, 'http')
  end

  def self.to_https(url)
    url ||= ''
    protocol = URI(url).scheme
    converters[protocol].try(:to_https, url) || url.gsub(protocol, 'https')
  end

end
