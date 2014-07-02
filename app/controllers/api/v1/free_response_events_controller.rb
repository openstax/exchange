class Api::V1::FreeResponseEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents the user submitting a free response answer'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (string), occurred_at (datetime) and metadata (text).

      Additionally, FreeResponseInputEvents have the object (string) and value (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/free_response_input_events', 'Creates a new FreeResponseInputEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user submitting a free response answer.

    #{json_schema(Api::V1::InputEventRepresenter, include: :simple)}
  EOS
  def create
    event_create(InputEvent) do |e|
      e.category = 'free_response'
      e.input_type = 'text'
    end
  end

end
