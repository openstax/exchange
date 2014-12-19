class TaskingEvent < ActiveRecord::Base
  acts_as_event

  belongs_to :taskee, class_name: 'Person', inverse_of: :tasked_events

  validates :taskee, presence: true
end
