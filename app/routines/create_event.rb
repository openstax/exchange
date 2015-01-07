class CreateEvent

  TASK_OPTIONS = [:identifier, :identifier_id, :resource, :resource_id, :trial]

  lev_routine

  uses_routine StandardCreate,
               as: :create,
               translations: { inputs: { scope: :event },
                               outputs: { map: { object: :event }}}

  uses_routine ProcessEvent,
               as: :process,
               translations: { inputs: { scope: :activities },
                               outputs: { type: :verbatim }}

  protected

  def exec(event_class, options={}, &block)

    options = options.with_indifferent_access
    event_options = options.except(*TASK_OPTIONS)
    task_options = options.slice(*TASK_OPTIONS)
    run(:create, event_class, event_options) do |event|
      event.task = task_options.empty? ? \
                     Task.new : Task.find_or_initialize_by(task_options)
      block.call(event) unless block.nil?
      transfer_errors_from(event.task, {type: :verbatim}, true) \
        unless event.task.valid?
    end

    run(:process, outputs[:event])

  end
end
