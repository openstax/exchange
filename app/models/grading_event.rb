class GradingEvent < ActiveRecord::Base
  acts_as_event

  validates :grader, presence: true
  validates :grade, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 1,
    allow_nil: true
  }
end
