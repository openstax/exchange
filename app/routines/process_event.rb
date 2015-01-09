class ProcessEvent

  include Lev::Delegator

  delegate AnswerEvent, to: Activity::MergeEventIntoExerciseActivity

end
