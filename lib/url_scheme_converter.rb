class UrlSchemeConverter

  cattr_accessor :converters
  self.converters = HashWithIndifferentAccess.new

  def self.register(scheme, converter)
    converters[scheme] = converter
  end

  def self.convert(url, to: :https)
    return if url.nil?
    uri = URI(url)

    converter = converters[uri.scheme]
    return converter.call(url, to) unless converter.nil?

    uri.scheme = to.to_s
    uri.to_s
  end

end
