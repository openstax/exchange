class GradingEvent < ActiveRecord::Base
  acts_as_event

  validates :grade, presence: true
end
