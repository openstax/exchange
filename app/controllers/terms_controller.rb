class TermsController < ApplicationController
  acts_as_interceptor
  skip_interceptor :authenticate_user!, only: [:index, :show]
  fine_print_skip :general_terms_of_use, :privacy_policy

  layout "layouts/application_body_only"

  def index
    @contracts = FinePrint::Contract.all
    redirect_to root_path, alert: 'The terms are temporarily unavailable.  Check back soon.' \
      if @contracts.empty?
  end

  def show
    @contract = FinePrint.get_contract(params[:id])
    # Hide old agreements (should never get them)
    raise ActiveRecord::RecordNotFound if !@contract.is_latest?
  end

  def pose
    instance_exec(current_account, &FinePrint.can_sign_proc)
    @contracts = params['terms'].collect{|t| FinePrint.get_contract(t)}
  end

  def agree
    handle_with(TermsAgree,
                caller: current_account,
                complete: lambda { fine_print_return })
  end
end
