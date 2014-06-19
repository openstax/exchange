OpenStax::Accounts.configure do |config|
  config.openstax_accounts_url = 'http://localhost:2999/' if !Rails.env.production?
  config.openstax_application_id = SECRET_SETTINGS[:openstax_application_id]
  config.openstax_application_secret = SECRET_SETTINGS[:openstax_application_secret]
  config.logout_via = :delete
  config.enable_stubbing = SECRET_SETTINGS[:openstax_application_id].nil?
end

OpenStax::Accounts::ApplicationController.class_exec do
  helper ApplicationFooterHelper, ApplicationHelper, ApplicationTopNavHelper,
         AlertHelper, OpenStax::Utilities::OsuHelper
end
