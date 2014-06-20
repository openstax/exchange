module Manage
  class BaseController < ApplicationController

    before_filter :authenticate_agent!

  end
end
