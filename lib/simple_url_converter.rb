class SimpleUrlConverter

  attr_reader :url_base

  def initialize(url_base)
    @url_base = url_base
  end

  def call(url, scheme)
    u = URI(url)
    "#{scheme}://#{@url_base}/#{u.host || ''}#{u.path || ''}#{u.query || ''}"
  end

end
