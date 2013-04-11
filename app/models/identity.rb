class Identity < ActiveRecord::Base
  before_create :set_value

protected

  def set_value

  end

end
