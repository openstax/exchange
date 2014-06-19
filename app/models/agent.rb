class Agent < ActiveRecord::Base
  include User

  attr_accessible :is_manager
end
