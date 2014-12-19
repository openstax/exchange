class Api::V1::InputEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user inputting information into a form'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, InputEvents have the input_type (string) and value (text) fields.
    EOS
  end

  api :POST, '/events/identifiers/inputs', 'Creates a new InputEvent.'
  description <<-EOS
    Creates an Event that records the user inputting information into a form or similar.

    #{json_schema(Api::V1::InputEventRepresenter, include: :writeable)}
  EOS
  def create
    create_event(InputEvent)
  end

end
