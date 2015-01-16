class Task < ActiveRecord::Base
  belongs_to :identifier, inverse_of: :tasks
  belongs_to :resource, inverse_of: :tasks

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

  validates :identifier, presence: true
  validates :resource, presence: true
  validates :trial, presence: true,
                    uniqueness: { scope: [:identifier_id, :resource_id] }

  # Look for a duplicate record in the DB. If not found, save and return self.
  def find_or_create
    # Try to find duplicates in the DB
    duplicate_task = Task.find_by(identifier: identifier,
                                  resource: resource,
                                  trial: trial)

    # Return pre-existing task if found
    return duplicate_task unless duplicate_task.nil?

    # No duplicates. Attempt to save and return self.
    save
    self
  end

end
