module Admin
  class AdministratorsController < BaseController

    def index
      handle_with(Admin::AccountsIndex, caller: current_account,
                                        user_type: 'Administrator',
                                        complete: lambda {
                                          @user_class = Administrator
                                          render 'admin/users/index'
                                        })
    end

    def create
      @account = OpenStax::Accounts::Account.find(params[:account_id])
      @administrator = Administrator.new
      @administrator.account = @account
      if @administrator.save
        redirect_to admin_path, notice: 'Administrator created.'
      else
        redirect_to admin_path, alert: 'Already an administrator. '
      end
    end

    def destroy
      Administrator.find(params[:id]).destroy
      redirect_to admin_path, notice: 'Administrator removed.'
    end

  end
end
