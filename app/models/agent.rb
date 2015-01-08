class Agent < ActiveRecord::Base
  acts_as_user(application_specific: true)
end
