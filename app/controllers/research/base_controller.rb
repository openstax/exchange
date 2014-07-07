module Research
  class BaseController < ApplicationController

    layout 'application_body_nav'

    before_filter :authenticate_researcher!

    def index
    end

  end
end
