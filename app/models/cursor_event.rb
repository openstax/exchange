class CursorEvent < ActiveRecord::Base
  acts_as_event

  attr_accessible :clicked, :object, :x_position, :y_position
end
