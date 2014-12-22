class Api::V1::ClickEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents a user moving their cursor over a tracked UI object'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: platform (object),
      person (object), resource (string) and context (string).

      Additionally, ClickEvents have the href (string), action (string)
      x_position (integer) and y_position (integer) fields.
    EOS
  end

  api :POST, '/events/identifiers/clicks', 'Creates a new MouseClickEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user clicking on a tracked UI object.

    #{json_schema(Api::V1::ClickEventRepresenter, include: :writeable)}
  EOS
  def create
    create_event(ClickEvent)
  end

end
