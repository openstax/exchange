class Api::V1::GradingEventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents a user\'s work being graded'
    description <<-EOS
      This controller uses the Client Credentials flow.

      All events have the following fields in common:
      identifier (uid), resource (string), occurred_at (datetime) and metadata (text).

      Additionally, GradingEvents have the grader (uid), grade (float) and
      feedback (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/grading_events', 'Creates a new GradingEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates an Event that records a user's work being graded.

    #{json_schema(Api::V1::GradingEventRepresenter, include: :writable)}
  EOS
  def create
    @event = standard_create(GradingEvent) do |event|
      event.identifier = doorkeeper_token.token
    end
    respond_with @event
  end

end