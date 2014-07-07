module Admin
  class ApplicationsController < Doorkeeper::ApplicationsController

    before_filter :authenticate_administrator!

    protected

    def application_params
      return {} if params[:application].nil?
      params[:application].slice(:name, :redirect_uri)
    end

  end
end
