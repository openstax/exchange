module Admin
  class PlatformsController < ApplicationsController

    def index
      @platforms = Platform.all
    end

    def new
      @platform = Platform.new
    end

    def create
      Platform.transaction do
        super
        @platform = Platform.new
        @platform.application = @application
        @platform.save!
      end
    end

    protected

    def set_application
      @platform = Platform.find(params[:id])
      @application = @platform.application
    end

  end
end
