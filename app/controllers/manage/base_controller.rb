module Manage
  class BaseController < ApplicationController

    layout 'application_body_nav'

    before_filter :authenticate_agent!

    def index
      render 'manage/index'
    end

  end
end
