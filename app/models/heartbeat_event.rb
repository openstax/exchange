class HeartbeatEvent < ActiveRecord::Base
  acts_as_event

  attr_accessible :scroll_position
end
