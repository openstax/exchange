module Admin
  class ResearchersController < BaseController

    def index
      handle_with(Admin::AccountsIndex, caller: current_account,
                                        user_type: 'Researcher',
                                        complete: lambda {
                                          @user_class = Researcher
                                          render 'admin/users/index'
                                        })
    end

    def create
      @account = OpenStax::Accounts::Account.find(params[:account_id])
      @researcher = Researcher.new
      @researcher.account = @account
      if @researcher.save
        redirect_to admin_path, notice: 'Researcher created.'
      else
        redirect_to admin_path, alert: 'Already a researcher. '
      end
    end

    def destroy
      Researcher.find(params[:id]).destroy
      redirect_to admin_path, notice: 'Researcher removed.'
    end

  end
end
