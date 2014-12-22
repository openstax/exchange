# Load the rails application
require File.expand_path('../application', __FILE__)

SITE_NAME = 'OpenStax Exchange'
COPYRIGHT_HOLDER = 'Rice University'
COPYRIGHT_START_YEAR = 2013

require 'user'
require 'app'
require 'event'
require 'eventful'
require 'activity'
require 'active'
require 'url_protocol_converter'
require 'lev/delegator'

# Initialize the rails application
Exchange::Application.initialize!
