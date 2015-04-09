OpenStax::Accounts.configure do |config|
  secrets = Rails.application.secrets['openstax']['accounts']

  # By default, stub unless in the production environment
  stub = secrets['stub'].nil? ? !Rails.env.production? : secrets['stub']

  config.openstax_application_id = secrets['client_id']
  config.openstax_application_secret = secrets['secret']
  config.openstax_accounts_url = secrets['url']
  config.enable_stubbing = stub
  config.logout_via = :delete
end
