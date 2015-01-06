class GradingEvent < ActiveRecord::Base
  acts_as_event

  validates :grader, presence: true
  validates :grade, presence: true
end
