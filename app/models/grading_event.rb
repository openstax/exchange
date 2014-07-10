class GradingEvent < ActiveRecord::Base
  acts_as_event

  belongs_to :grader, class_name: 'Person'
end
