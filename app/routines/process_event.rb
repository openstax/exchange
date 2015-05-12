class ProcessEvent

  include Lev::Delegator

  delegate AnswerEvent, GradingEvent, to: Activity::MergeEventIntoExerciseActivity

end
