class SimpleUrlConverter

  def initialize(host)
    @host = host.to_s
  end

  def call(url, scheme)
    u = URI(url)
    u.path = "/#{u.host}"
    u.host = @host
    u.scheme = scheme.to_s
    u.to_s
  end

end
