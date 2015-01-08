module Activity
  class MergeEventIntoExerciseActivity

    lev_routine

    uses_routine CreateOrUpdateActivityFromEvent,
                 as: :activity,
                 translations: { inputs: { scope: :activity },
                                 outputs: { type: :verbatim }}

    protected

    def exec(event, options={})

      run(:activity, ExerciseActivity, event) do |activity|
        case event
        when AnswerEvent
          activity.correctness = event.correctness \
            unless event.correctness.nil?
          if event.answer_type == 'free-response'
            activity.free_response = event.answer
          else
            activity.answer = event.answer
          end
        end
      end

    end
  end
end
