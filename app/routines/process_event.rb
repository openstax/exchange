class ProcessEvent

  include Lev::Delegator

  delegate InputEvent, to: Activity::MergeEventIntoExerciseActivity

end
