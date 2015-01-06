class TaskingEvent < ActiveRecord::Base
  acts_as_event

  validates :tasker, presence: true
end
