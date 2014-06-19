class ApplicationController < ActionController::Base
  include Lev::HandleWith

  respond_to :html

  layout :layout

  undef_method :current_user

  protected

  def layout
    "application_body_only"
  end

end
