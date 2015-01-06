class CreateTask

  lev_routine

  uses_routine StandardCreate,
               as: :create,
               translations: { inputs: { scope: :task },
                               outputs: { map: { object: :task }}}

  uses_routine FindOrCreateResourceFromUrl,
               as: :resource,
               translations: { inputs: { scope: :resource }}

  protected

  def exec(options={}, &block)

    options = options.with_indifferent_access
    run(:create, Task, options.except(:resource)) do |task|
      task.resource = run(:resource, options[:resource]).outputs[:resource] \
        if options[:resource]
      block.call(task) unless block.nil?
    end

  end
end
