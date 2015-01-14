class ExerciseActivity < ActiveRecord::Base
  acts_as_activity

  has_many :answer_events, through: :task
end
