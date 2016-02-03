class FindOrCreateTask

  lev_routine transaction: :serializable

  protected

  # Given an unsaved Task, attempts to find a duplicate record in the DB,
  # otherwise saves and returns the task
  def exec(task)

    # Try to find duplicates in the DB
    duplicate_task = Task.lock.find_by(identifier: task.identifier,
                                       resource: task.resource,
                                       trial: task.trial)

    # Return pre-existing task if found or save if not
    if duplicate_task.nil?
      task.save
      transfer_errors_from(task, {type: :verbatim}, true)
      outputs[:task] = task
    else
      outputs[:task] = duplicate_task
    end

  end

end
