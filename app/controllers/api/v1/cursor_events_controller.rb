class Api::V1::CursorEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user moving the mouse over a tracked UI object'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, CursorEvents have the href (string), action (string)
      x_position (integer) and y_position (integer) fields.
    EOS
  end

  api :POST, '/events/identifiers/mouse_movements',
             'Creates a new MouseMovementEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user moving the mouse over a tracked UI object.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :writeable)}
  EOS
  def create_mouse_movement
    create_event(CursorEvent) do |e|
      e.action = 'mouse-movement'
    end
  end

  api :POST, '/events/identifiers/mouse_clicks', 'Creates a new MouseClickEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user clicking on a tracked UI object.

    #{json_schema(Api::V1::CursorEventRepresenter, include: :writeable)}
  EOS
  def create_mouse_click
    create_event(CursorEvent) do |e|
      e.action = 'mouse-click'
    end
  end

end
