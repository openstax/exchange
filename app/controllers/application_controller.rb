class ApplicationController < ActionController::Base
  include Lev::HandleWith

  respond_to :html

  layout :layout

  def current_user
    current_account
  end

  protected

  def layout
    "application_body_only"
  end

end
