class HeartbeatEvent < ActiveRecord::Base
  INTERVAL = 15.seconds

  acts_as_event
end
