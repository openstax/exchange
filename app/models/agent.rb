class Agent < ActiveRecord::Base
  acts_as_user

  attr_accessible :is_manager
end
