# Load the rails application
require File.expand_path('../application', __FILE__)

SITE_NAME = "OpenStax Exchange"
COPYRIGHT_HOLDER = "Rice University"
COPYRIGHT_START_YEAR = 2013

require 'secret_settings'
require 'controller_extensions'
require 'utilities'
require 'user'
require 'app'
require 'event'
require 'event_rest'
require 'activity'
require 'referable'

# Initialize the rails application
Exchange::Application.initialize!
