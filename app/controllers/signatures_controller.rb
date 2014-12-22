class SignaturesController < ApplicationController

  acts_as_interceptor
  fine_print_skip :general_terms_of_use, :privacy_policy

  layout "layouts/application_body_only"

  def new
    instance_exec(current_account, &FinePrint.can_sign_proc)
    @contracts = params['terms'].collect{|t| FinePrint.get_contract(t)}
  end

  def create
    handle_with(TermsAgree,
                caller: current_account,
                complete: lambda { fine_print_return })
  end

end
