# Load the rails application
require File.expand_path('../application', __FILE__)

SITE_NAME = "OpenStax Exchange"
COPYRIGHT_HOLDER = "Rice University"
COPYRIGHT_START_YEAR = 2013

require 'secret_settings'
require 'extend_builtins'
require 'utilities'

# Initialize the rails application
Exchange::Application.initialize!
