class TermsController < ApplicationController

  skip_interceptor :authenticate_user!, only: [:index, :show]
  fine_print_skip :general_terms_of_use, :privacy_policy

  layout "layouts/application_body_only"

  def index
    @contracts = FinePrint::Contract.all
    redirect_to root_path,
      alert: 'The terms are temporarily unavailable. Check back soon.' \
        if @contracts.empty?
  end

  def show
    @contract = FinePrint.get_contract(params[:id])
    # Hide old terms
    raise ActiveRecord::RecordNotFound if !@contract.is_latest?
  end

end
