class FindOrCreateTask

  lev_routine

  protected

  # Given an unsaved Task, attempts to find a duplicate record in the DB,
  # otherwise saves and returns the task
  def exec(task)

    lock_name = self.class.name

    lock_result = Task.with_advisory_lock_result(lock_name, DEFAULT_LOCK_TIMEOUT_SECS) do
      outputs[:task] = Task.find_by(identifier: task.identifier,
                                    resource: task.resource,
                                    trial: task.trial) || task
      outputs[:task].save unless outputs[:task].persisted?
    end

    if !lock_result.lock_was_acquired?
      fatal_error(code: :lock_not_acquired, message: "Could not acquire '#{lock_name}' lock")
    end

    transfer_errors_from(outputs[:task], {type: :verbatim}, true)

  end

end
