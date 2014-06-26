class TaskEvent < ActiveRecord::Base
  acts_as_event

  attr_accessible :assigner_id, :assigner_type, :due_date, :is_complete, :number
end
