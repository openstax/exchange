require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rails/commands/server'

DEV_PORT = 3003
DEV_HOST = "localhost:#{DEV_PORT}"

module Rails
  class Server
    alias :default_options_without_port :default_options
    def default_options
      default_options_without_port.merge(:Port => DEV_PORT)
    end    
  end
end
