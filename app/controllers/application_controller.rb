class ApplicationController < ActionController::Base
  protect_from_forgery
  protect_beta :username => SECRET_SETTINGS[:beta_username],
               :password => SECRET_SETTINGS[:beta_password]

  include Lev::HandleWith

  before_filter :authenticate_user!
end

