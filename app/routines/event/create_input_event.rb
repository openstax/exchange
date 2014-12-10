module Event
  class CreateInputEvent

    lev_routine
    uses_routine StandardCreate,
                 as: :create,
                 translations: { inputs: { scope: :event },
                                 outputs: { map: { input_event: :event }}}
    uses_routine FindOrCreateActivityByEvent,
                 as: :activity,
                 translations: { inputs: { scope: :activity },
                                 outputs: { type: :verbatim }}

    protected

    def exec(options={}, &block)

      run(:create, InputEvent, options, &block)

      run(:activity, ExerciseActivity, outputs[:event]) do |activity|
        activity.answer = ''
        activity.correct = false
        activity.free_response = ''
      end

    end
  end
end
