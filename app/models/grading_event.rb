class GradingEvent < ActiveRecord::Base
  acts_as_event

  attr_accessible :feedback, :grade, :grader_id, :grader_type
end
