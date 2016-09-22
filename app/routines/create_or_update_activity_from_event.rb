class CreateOrUpdateActivityFromEvent

  lev_routine

  uses_routine PublishActivity, as: :publish, ignored_errors: [:aws_credentials_blank]

  protected

  def exec(activity_class, event, options={})

    # Make the lock specific to the Activity class and task ID
    lock_name = "#{activity_class.name}:task-#{event.task.id}"

    lock_result = activity_class.with_advisory_lock_result(lock_name, DEFAULT_LOCK_TIMEOUT_SECS) do
      activity = activity_class.find_or_initialize_by(task: event.task)

      activity.first_event_at ||= Time.now
      activity.last_event_at = Time.now
      activity.seconds_active ||= 0
      activity.seconds_active += HeartbeatEvent::INTERVAL if event.is_a? HeartbeatEvent

      yield activity if block_given?

      activity.save

      outputs[:activity] = activity
    end

    if !lock_result.lock_was_acquired?
      fatal_error(code: :lock_not_acquired, message: "Lock not acquired for #{lock_name}")
    end

    transfer_errors_from outputs[:activity], type: :verbatim

    #run(:publish, activity) # Skipped until Amazon SQS integration is ready

  end

end
