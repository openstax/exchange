require 'openstax_rescue_from'

OpenStax::RescueFrom.configure do |config|
  config.raise_exceptions = ![false, 'false'].include?(ENV['RAISE_EXCEPTIONS']) ||
                              Rails.application.config.consider_all_requests_local

  config.app_name = 'Exchange'
  # config.app_env = ENV['APP_ENV']
  # config.contact_name = ENV['EXCEPTION_CONTACT_NAME']

  # config.notifier = ExceptionNotifier

  # config.html_error_template_path = 'errors/any'
  # config.html_error_template_layout_name = 'application'

  # config.email_prefix = "[#{app_name}] (#{app_env}) "
  # config.sender_address = ENV['EXCEPTION_SENDER']
  # config.exception_recipients = ENV['EXCEPTION_RECIPIENTS']
end

OpenStax::RescueFrom.translate_status_codes({
  forbidden: "You are not allowed to access this.",
  :not_found => 'Sorry, we could not find that resource.',
  bad_request: 'The request was unrecognized.',
  forbidden: 'You are not allowed to do that.',
  unprocessable_entity: 'The entity could not be processed.'
})
