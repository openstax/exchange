module Event
  class CreatePageEvent

    lev_routine
    uses_routine StandardCreate,
                 as: :create,
                 translations: { inputs: { scope: :event },
                                 outputs: { map: { page_event: :event }}}
    uses_routine FindOrCreateActivityByEvent,
                 as: :activity,
                 translations: { inputs: { scope: :activity },
                                 outputs: { type: :verbatim }}

    protected

    def exec(options={}, &block)

      run(:create, PageEvent, options, &block)

    end
  end
end
