class InputEvent < ActiveRecord::Base
  acts_as_event

  attr_accessible :data, :data_type, :filename, :input_type, :object
end
