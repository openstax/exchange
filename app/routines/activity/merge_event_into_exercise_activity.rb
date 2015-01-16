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
        when GradingEvent
          # TODO: Compute assignment grade if 2+ grading events
          activity.grade = event.grade
        end
      end

    end
  end
end
