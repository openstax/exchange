require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def api_request(type, path, api_key_or_token='', params={}, env={}, &block)
  token = (api_key_or_token.is_a? ApiKey) ? api_key_or_token.access_token : api_key_or_token
  env['HTTP_AUTHORIZATION'] = "Token token=\"#{token}\""
  params[:format] = 'json'

  case type
  when :get
    get path, params, env, &block
  when :post 
    post path, params, env, &block
  when :put
    put path, params, env, &block
  when :delete
    delete path, params, env, &block
  end
end
