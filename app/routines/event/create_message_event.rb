module Event
  class CreateMessageEvent

    lev_routine
    uses_routine StandardCreate,
                 as: :create,
                 translations: { inputs: { scope: :event },
                                 outputs: { map: { message_event: :event }}}
    uses_routine FindOrCreateActivityByEvent,
                 as: :activity,
                 translations: { inputs: { scope: :activity },
                                 outputs: { type: :verbatim }}

    protected

    def exec(options={}, &block)

      run(:create, MessageEvent, options, &block)

    end
  end
end
