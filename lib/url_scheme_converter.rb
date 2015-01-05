class UrlSchemeConverter

  cattr_accessor :converters
  self.converters = HashWithIndifferentAccess.new

  def self.register(scheme, converter)
    converters[scheme] = converter
  end

  def self.convert(url, to: :https)
    return if url.nil?
    scheme = URI(url).scheme
    converters[scheme].try(:call, url, to) || url.gsub(scheme, to.to_s)
  end

end
