class GradingEvent < ActiveRecord::Base
  acts_as_event

  validates_presence_of :grader_id
end
