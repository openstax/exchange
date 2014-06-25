class Api::V1::CursorEventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user moving the mouse over or clicking on a tracked UI object'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common:
      identifier (uid), resource (uid), occurred_at (datetime) and metadata (text).

      Additionally, CursorEvents have the object (uid), clicked (boolean) and eye_tracking (boolean) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/cursor_events', 'Creates a new CursorEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user moving the mouse over or clicking on a tracked UI object.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :writable)}
  EOS
  def create
    OSU::AccessPolicy.require_action_allowed!(:create, current_api_user, CursorEvent)
    @event = standard_create(CursorEvent) do |cursor_event|
      cursor_event.identifier = doorkeeper_token.token
    end
    respond_with @event
  end

end
