Apipie.configure do |config|
  config.app_name                = "#{SITE_NAME} API"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api/docs"
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.copyright               = Utilities::copyright_text
  config.layout                  = 'application_body_api_docs'
  config.markup                  = Apipie::Markup::Markdown.new
  config.namespaced_resources    = false
end
