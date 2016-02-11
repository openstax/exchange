class FindOrCreateTask

  lev_routine

  protected

  # Given an unsaved Task, attempts to find a duplicate record in the DB,
  # otherwise saves and returns the task
  def exec(task)

    outputs[:task] = Task.find_by(identifier: task.identifier,
                                  resource: task.resource,
                                  trial: task.trial) || task
    outputs[:task].save unless outputs[:task].persisted?
    transfer_errors_from(outputs[:task], {type: :verbatim}, true)

  end

end
