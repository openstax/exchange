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
        activity.answer = ''
        activity.correctness = 0.0
        activity.free_response = ''
      end

    end
  end
end
