source 'https://rubygems.org'

gem 'rails', '3.2.17'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '~> 3.1.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder'
gem 'whenever', :require => false
gem 'newrelic_rpm'
gem 'squeel'
gem 'yaml_db'

gem 'openstax_utilities', '~> 2.2.3'
gem 'openstax_accounts', :path => '../accounts-rails'
gem 'openstax_api', :path => '../openstax_api'

gem 'apipie-rails'
gem 'maruku'

gem 'doorkeeper'

gem 'representable', '~> 1.8.3'
gem 'roar-rails'

gem 'exception_notification'

gem 'action_interceptor', '~> 0.2.3'
gem 'fine_print', '~> 1.4.1'

gem 'lev', '~> 2.1.0'

group :development, :test do
  gem 'sqlite3'
  gem 'debugger'
  gem 'faker'
  gem 'thin'
  gem 'quiet_assets'
  gem 'cheat'
  gem 'brakeman'
  gem 'railroady'
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'nifty-generators'
  gem 'factory_girl_rails'
  gem 'rack-test', require: 'rack/test'
end

group :production do
  gem 'mysql2'
  gem 'unicorn'
  gem 'lograge', '~> 0.3.0'
end
