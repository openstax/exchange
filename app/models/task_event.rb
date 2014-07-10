class TaskEvent < ActiveRecord::Base
  acts_as_event

  belongs_to :assigner, class_name: 'Person'

  validates_presence_of :number
end
