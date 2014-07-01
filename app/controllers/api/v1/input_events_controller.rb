class Api::V1::InputEventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user inputting some information into a form or similar'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (string), occurred_at (datetime) and metadata (text).

      Additionally, InputEvents have the object (string), action (string),
      data_type (string), data (text) and file_name (string) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/input_events', 'Creates a new InputEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user inputting some information into a form or similar.

    #{json_schema(Api::V1::InputEventRepresenter, include: :writeable)}
  EOS
  def create
    @event = standard_create(InputEvent) do |event|
      event.identifier = doorkeeper_token.token
    end
    respond_with @event
  end

end
