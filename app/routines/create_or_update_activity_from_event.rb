class CreateOrUpdateActivityFromEvent

  lev_routine

  protected

  def exec(activity_class, event, options={})

    activity = activity_class.find_or_initialize_by(
                 platform_id: event.platform_id,
                 person_id: event.person_id,
                 resource_id: event.resource_id,
                 attempt: event.attempt
               )

    activity.first_event_at ||= Time.now
    activity.last_event_at = Time.now
    activity.seconds_active ||= 0
    activity.seconds_active += HeartbeatEvent::INTERVAL \
      if event.is_a? HeartbeatEvent

    yield activity if block_given?

    activity.save

    outputs[:activity] = activity
    transfer_errors_from activity, type: :verbatim

  end
end
