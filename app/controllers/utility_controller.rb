class UtilityController < ApplicationController

  skip_protect_beta :only => [:status]

  def status
    head :ok
  end

end