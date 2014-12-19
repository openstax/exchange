class CursorEvent < ActiveRecord::Base
  acts_as_event

  validates :action, presence: true
end
