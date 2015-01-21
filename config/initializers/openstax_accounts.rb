OpenStax::Accounts.configure do |config|
  config.openstax_accounts_url = 'http://localhost:2999/' if !Rails.env.production?
  accounts_secrets = Rails.application.secrets['openstax']['accounts']
  config.openstax_application_id = accounts_secrets['application_uid']
  config.openstax_application_secret = accounts_secrets['application_secret']
  config.logout_via = :delete
  config.enable_stubbing = true
end
