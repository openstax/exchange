class InputEvent < ActiveRecord::Base
  acts_as_event

  validates :input_type, presence: true
end
