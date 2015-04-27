class SignaturesController < ApplicationController

  fine_print_skip
  before_filter :can_sign

  layout "layouts/application_body_only"

  def new
    @contracts = params[:terms].collect{|t| FinePrint.get_contract(t)}
  end

  def create
    handle_with(TermsAgree,
                caller: current_account,
                complete: lambda { fine_print_return })
  end

  protected

  def can_sign
    instance_exec current_account, &FinePrint.config.authenticate_user_proc
  end

end
