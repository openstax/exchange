class Api::V1::HeartbeatEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user remaining on a resource page'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, HeartbeatEvents have the and y_position (integer) field.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/events/identifiers/heartbeats', 'Creates a new HeartbeatEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user staying in a Resource page in their browser.

    #{json_schema(Api::V1::HeartbeatEventRepresenter, include: :writeable)}
  EOS
  def create
    create_event(HeartbeatEvent)
  end

end
