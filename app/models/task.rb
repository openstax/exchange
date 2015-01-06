class Task < ActiveRecord::Base
  belongs_to :person, inverse_of: :tasks
  belongs_to :resource, inverse_of: :tasks
  belongs_to :platform, inverse_of: :tasks

  has_many :load_events,      inverse_of: :task
  has_many :heartbeat_events, inverse_of: :task
  has_many :link_events,      inverse_of: :task
  has_many :unload_events,    inverse_of: :task
  has_many :answer_events,    inverse_of: :task
  has_many :grading_events,   inverse_of: :task
  has_many :tasking_events,   inverse_of: :task

  has_many :exercise_activities,     inverse_of: :task
  has_many :feedback_activities,     inverse_of: :task
  has_many :interactive_activities,  inverse_of: :task
  has_many :peer_grading_activities, inverse_of: :task
  has_many :reading_activities,      inverse_of: :task

  validates :person, presence: true
  validates :resource, presence: true
  validates :platform, presence: true
  validates :trial,
            presence: true,
            uniqueness: { scope: [:person_id, :resource_id, :platform_id] }
end
