module Admin
  class SubscribersController < ApplicationsController

    def index
      @subscribers = Subscriber.all
    end

    def new
      @subscriber = Subscriber.new
    end

    def create
      Subscriber.transaction do
        super
        @subscriber = Subscriber.new
        @subscriber.application = @application
        @subscriber.save!
      end
    end

    protected

    def set_application
      @subscriber = Subscriber.find(params[:id])
      @application = @subscriber.application
    end

  end
end
