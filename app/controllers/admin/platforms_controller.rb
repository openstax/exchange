module Admin
  class PlatformsController < ApplicationsController

    layout 'application_body_nav'

    before_filter :authenticate_administrator! if Rails.env.production?

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
