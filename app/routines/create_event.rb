class CreateEvent

  TASK_OPTIONS = [:person, :person_id, :platform, :platform_id,
                  :resource, :resource_id, :trial]

  lev_routine

  uses_routine StandardCreate,
               as: :create,
               translations: { inputs: { scope: :event },
                               outputs: { map: { object: :event }}}

  uses_routine CreateTask,
               as: :task,
               translations: { inputs: { scope: :task }}

  uses_routine ProcessEvent,
               as: :process,
               translations: { inputs: { scope: :activities },
                               outputs: { type: :verbatim }}

  protected

  def exec(event_class, options={}, &block)

    options = options.with_indifferent_access
    run(:create, event_class, options.except(*TASK_OPTIONS)) do |event|
      event.task = run(:task, options.slice(*TASK_OPTIONS)).outputs[:task]
      block.call(event) unless block.nil?
    end

    run(:process, outputs[:event])

  end
end
