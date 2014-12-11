class CreateEvent

  lev_routine

  uses_routine StandardCreate,
               as: :create,
               translations: { inputs: { scope: :event },
                               outputs: { map: { object: :event }}}

  uses_routine EventListeners,
               as: :listeners,
               translations: { inputs: { scope: :activities },
                               outputs: { type: :verbatim }}

  protected

  def exec(event_class, options={}, &block)

    run(:create, event_class, options, &block)

    run(:listeners, outputs[:event])

  end
end
