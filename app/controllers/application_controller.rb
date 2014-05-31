class ApplicationController < ActionController::Base
  include Lev::HandleWith

  respond_to :html

  layout :layout

  before_filter :authenticate_user!

protected

  def authenticate_admin!
    raise SecurityTransgression unless current_user.is_admin?
  end

  def layout
    "application_body_only"
  end

end
