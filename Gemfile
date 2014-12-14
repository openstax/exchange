# Copyright 2011-2014 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

source 'https://rubygems.org'

# Rails framework
gem 'rails', '4.2.0.beta2'

# Remove this when Squeel is updated to support Arel 6.0.0
gem 'arel', '6.0.0.beta2'

# Bootstrap
gem 'bootstrap-sass', '~> 3.2.0'

# SCSS stylesheets
gem 'sass-rails', '~> 5.0.0'

# Automatically add browser-specific CSS prefixes
gem 'autoprefixer-rails'

# JavaScript asset compressor
gem 'uglifier', '>= 1.3.0'

# CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# JavaScript asset compiler
gem 'therubyracer', platforms: :ruby

# jQuery library
gem 'jquery-rails'

# jQuery UI library
gem 'jquery-ui-rails'

# Automatically ajaxify links
gem 'turbolinks'

# Rails 5 HTML sanitizer
gem 'rails-html-sanitizer', '~> 1.0'

# Utilities for OpenStax websites
gem 'openstax_utilities'

# Cron job scheduling
gem 'whenever'

# OpenStax Accounts integration
gem 'openstax_accounts', git: 'https://github.com/Dantemss/accounts-rails.git',
                         ref: '8652f17db95c5b5fc561f4abd25735a6d36017c9'

# Respond_with and respond_to methods
gem 'responders', '~> 2.0'

# Access control for API's
gem 'doorkeeper'

# API versioning and documentation
gem 'openstax_api'
gem 'apipie-rails'
gem 'maruku'
gem 'representable'
gem 'roar-rails'

# Lev framework
gem 'lev'

# Ruby dsl for SQL queries
gem 'squeel'

# Contract management
gem 'fine_print'

# Keyword search
gem 'keyword_search'

# File uploads
gem 'remotipart'
gem 'carrierwave'

# Image editing
gem 'mini_magick'

# Embedded JavaScript templates
gem 'ejs'

# Embedded CoffeeScript templates
gem 'eco'

# Real time application monitoring
gem 'newrelic_rpm'

# YAML database backups
gem 'yaml_db'

# Admin console
gem 'rails_admin'

group :development, :test do
  # Thin webserver
  gem 'thin'

  # SQLite3 database
  gem 'sqlite3'

  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Mute asset pipeline log messages
  gem 'quiet_assets'

  # Fixture replacement
  gem 'factory_girl_rails'

  # Lorem Ipsum
  gem 'faker'
end

group :development do
  # Access an IRB console on exceptions page and /console in development
  gem 'web-console', '~> 2.0.0.beta2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Automated security checks
  gem 'brakeman'

  # Time travel gem
  gem 'timecop'

  # Command line reference
  gem 'cheat'

  # Assorted generators
  gem 'nifty-generators'

  # Class diagrams
  gem 'rails-erd'
  gem 'railroady'

  # CoffeeScript source maps
  gem 'coffee-rails-source-maps'
end

group :test do
  # Use RSpec for tests
  gem 'rspec-rails'

  # Spec helpers
  gem 'shoulda-matchers', require: false

  # Code Climate integration
  gem "codeclimate-test-reporter", require: false

  # Coveralls integration
  gem 'coveralls', require: false
end

group :production do
  # Unicorn production server
  gem 'unicorn'

  # PostgreSQL production database
  gem 'pg'

  # Notify developers of Exceptions in production
  gem 'exception_notification'
end
