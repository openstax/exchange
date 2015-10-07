class ApplicationController < ActionController::Base

  use_openstax_exception_rescue

  include Lev::HandleWith

  respond_to :html

  layout 'application_body_only'

  fine_print_require :general_terms_of_use, :privacy_policy

  def current_user
    current_account
  end

end
