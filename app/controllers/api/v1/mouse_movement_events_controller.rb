class Api::V1::MouseMovementEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents the user moving the mouse over a tracked UI object'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (string), occurred_at (datetime) and metadata (text).

      Additionally, MouseMovementEvents have the object (string),
      x_position (integer) and y_position (integer) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/mouse_movement_events', 'Creates a new MouseMovementEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user moving the mouse over a tracked UI object.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :writeable)}
  EOS
  def create
    event_create(CursorEvent)
  end

end
