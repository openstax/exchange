class ApplicationController < ActionController::Base
  protect_from_forgery
  protect_beta :username => SECRET_SETTINGS[:beta_username],
               :password => SECRET_SETTINGS[:beta_password]
end

