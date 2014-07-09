class TaskEvent < ActiveRecord::Base
  acts_as_event

  validates_presence_of :task_id
end
