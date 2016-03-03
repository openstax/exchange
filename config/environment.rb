# Load the rails application
require File.expand_path('../application', __FILE__)

SITE_NAME = 'OpenStax Exchange'
COPYRIGHT_HOLDER = 'Rice University'
COPYRIGHT_START_YEAR = 2013
DEFAULT_LOCK_TIMEOUT_SECS = 20

require 'user'
require 'app'
require 'event'
require 'activity'
require 'url_scheme_converter'
require 'simple_url_converter'
require 'date_time_utilities'
require 'lev/delegator'
require 'openstax/biglearn/client_error'
require 'openstax/biglearn/v1'

# Initialize the rails application
Exchange::Application.initialize!
