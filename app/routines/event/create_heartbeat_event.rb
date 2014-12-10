module Event
  class CreateHeartbeatEvent

    lev_routine
    uses_routine StandardCreate,
                 as: :create,
                 translations: { inputs: { scope: :event },
                                 outputs: { map: { heartbeat_event: :event }}}
    uses_routine FindOrCreateActivityByEvent,
                 as: :activity,
                 translations: { inputs: { scope: :activity },
                                 outputs: { type: :verbatim }}

    protected

    def exec(options={}, &block)

      run(:create, HeartbeatEvent, options, &block)

    end
  end
end
