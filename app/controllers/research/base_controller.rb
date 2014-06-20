module Research
  class BaseController < ApplicationController

    before_filter :authenticate_researcher!

  end
end
