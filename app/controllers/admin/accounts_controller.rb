module Admin
  class AccountsController < BaseController

    before_filter :get_account, only: [:become]

    def index
      handle_with(Admin::AccountsIndex)
    end

    def become
      sign_in(@account)
      redirect_to request.referrer
    end

  protected

    def get_account
      @account = OpenStax::Accounts::Account.find(params[:id])
    end

  end
end
