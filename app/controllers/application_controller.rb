class ApplicationController < ActionController::Base
  include Lev::HandleWith

  respond_to :html

  layout 'application_body_only'

  def current_user
    current_account
  end

end
