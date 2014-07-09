class Api::V1::CursorEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents the user moving the mouse over a tracked UI object'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, CursorEvents have the selector (string), action (string)
      x_position (integer) and y_position (integer) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/identifiers/events/cursors', 'Creates a new generic CursorEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user doing some action with the cursor.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :writeable)}
  EOS
  def create
    event_create(CursorEvent)
  end

  api :POST, '/identifiers/events/mouse_movements', 'Creates a new MouseMovementEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user moving the mouse over a tracked UI object.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :simple)}
  EOS
  def create_mouse_movement
    event_create(CursorEvent) do |e|
      e.action = 'mouse_movement'
    end
  end

  api :POST, '/identifiers/events/mouse_clicks', 'Creates a new MouseClickEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user clicking on a tracked UI object.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :simple)}
  EOS
  def create_mouse_click
    event_create(CursorEvent) do |e|
      e.action = 'mouse_click'
    end
  end

end
