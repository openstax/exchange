class Api::V1::TaskEventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the a task being assigned to a user'
    description <<-EOS
      This controller uses the Client Credentials flow.

      All events have the following fields in common:
      identifier (uuid), resource (string), occurred_at (datetime) and metadata (text).

      Additionally, TaskEvents have the following fields:

      number (integer), assigner (uuid), due_date (datetime), is_complete (boolean)
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/task_events', 'Creates a new TaskEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates an Event that records or updates a task assignment.

    #{json_schema(Api::V1::TaskEventRepresenter, include: :writeable)}
  EOS
  def create
    @event = standard_create(TaskEvent) do |event|
      event.identifier = doorkeeper_token.token
    end
    respond_with @event
  end

end
