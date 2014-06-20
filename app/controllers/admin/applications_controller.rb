module Admin
  class ApplicationsController < Doorkeeper::ApplicationsController

    before_filter :authenticate_administrator!

    def create
      @application = Doorkeeper::Application.new(application_params)
      parent = (params[:type].classify.constantize).new
      parent.application = @application
      if parent.save
        flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash,
                                                    :applications, :create])
        respond_with [:oauth, @application]
      else
        render :new
      end
    end

    protected

    def application_params
      return {} if params[:application].nil?
      params[:application].slice(:name, :redirect_uri)
    end

  end
end
