class ExerciseActivity < ActiveRecord::Base
  acts_as_activity

  process InputEvent do |activity, event|
    activity.answer = 1
    activity.correct = false
    activity.free_response = ''
  end
end
