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

gem 'sqlite3'
gem 'jquery-rails'
gem 'jbuilder'
gem 'whenever', :require => false
gem 'newrelic_rpm'
gem 'squeel'
gem 'yaml_db'
gem 'openstax_utilities', '~> 1.2.0'
gem 'openstax_connect', '~> 0.0.8'

gem 'apipie-rails'
gem 'maruku'

gem 'doorkeeper'

# see https://groups.google.com/d/msg/roar-talk/KI-a5t02huc/RKwkcZ5SzOEJ
# gem 'roar', git: 'git://github.com/andresf/roar.git', ref: '0698cb17515ae229bd10580a95062530aba4f583'
gem 'representable', git: 'git://github.com/jpslav/representable.git', ref: '0b8ba7a2e7a6ce0bc404fe5af9ead26295db1457'
gem 'roar-rails'

gem 'exception_notification'

gem 'lev', "~> 2.0.4"

group :development, :test do
  gem 'debugger'
  gem 'faker'
  gem 'thin'
  gem 'quiet_assets'
  gem 'cheat'
  gem 'brakeman'
  gem 'railroady'
  gem 'rspec-rails'
  gem 'rspec-rerun'
  gem 'cucumber-rails', :require => false
  gem 'nifty-generators'
end

group :development, :test do
  gem 'rack-test', require: "rack/test"
  gem 'factory_girl'
end

group :production do
  gem 'mysql2', '~> 0.3.11'
  gem 'unicorn'
  gem 'lograge', git: 'https://github.com/jpslav/lograge.git' # 'git@github.com:jpslav/lograge.git'
end


