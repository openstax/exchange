module Admin
  class AgentsController < BaseController

    def index
      handle_with(Admin::AccountsIndex, caller: current_account,
                                        user_type: 'Agent',
                                        complete: lambda {
                                          @user_class = Agent
                                          render 'admin/users/index'
                                        })
    end

    def create
      @account = OpenStax::Accounts::Account.find(params[:account_id])
      @agent = Agent.new
      @agent.account = @account
      if @agent.save
        redirect_to admin_path, notice: 'Agent created.'
      else
        redirect_to admin_path, alert: 'Already an agent. '
      end
    end

    def destroy
      Agent.find(params[:id]).destroy
      redirect_to admin_path, notice: 'Agent removed.'
    end

  end
end
