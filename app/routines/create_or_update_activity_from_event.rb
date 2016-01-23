class CreateOrUpdateActivityFromEvent

  lev_routine

  uses_routine PublishActivity, as: :publish, ignored_errors: [:aws_credentials_blank]

  protected

  def exec(activity_class, event, options={})

    activity = activity_class.lock.find_or_initialize_by(task: event.task)

    activity.first_event_at ||= Time.now
    activity.last_event_at = Time.now
    activity.seconds_active ||= 0
    activity.seconds_active += HeartbeatEvent::INTERVAL if event.is_a? HeartbeatEvent

    yield activity if block_given?

    activity.save

    outputs[:activity] = activity
    transfer_errors_from activity, type: :verbatim

    #run(:publish, activity) # Skipped until Amazon SQS integration is ready
    # Direct calling - hack to be used until we have Amazon SQS integration
    OpenStax::Biglearn::V1.send_response(exercise_activity: activity) if event.is_a?(GradingEvent)

  end

end
