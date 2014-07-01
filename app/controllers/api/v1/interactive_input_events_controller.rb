class Api::V1::InteractiveInputEventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user interacting with a simulation'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (string), occurred_at (datetime) and metadata (text).

      Additionally, InteractiveInputEvents have the object (string) and data (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/interactive_input_events', 'Creates a new InteractiveInputEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user interacting with a simulation.

    #{json_schema(Api::V1::InputEventRepresenter, include: :writeable)}
  EOS
  def create
    @event = standard_create(InteractiveInputEvent) do |event|
      event.identifier = doorkeeper_token.token
    end
    respond_with @event, represent_with: Api::V1::InputEventRepresenter
  end

end
