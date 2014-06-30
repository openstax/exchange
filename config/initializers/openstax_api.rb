OpenStax::Api.configure do |config|
  config.user_class_name = 'Person'
  config.current_user_method = 'current_account'
end
