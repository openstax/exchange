# Load the rails application
require File.expand_path('../application', __FILE__)

SITE_NAME = "OpenStax Exchange"
COPYRIGHT_HOLDER = "Rice University"

require 'utilities'

# Initialize the rails application
Exchange::Application.initialize!
