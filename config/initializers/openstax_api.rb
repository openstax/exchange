OpenStax::Api.configure do |config|
  config.user_class_name = 'Identifier'
  config.current_user_method = 'current_user'
end

OpenStax::Api::V1::ApiController.class_eval do
  use_openstax_exception_rescue
end
