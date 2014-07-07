class Api::V1::MessageEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents the user sending a message to other users'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (string), occurred_at (datetime) and metadata (text).

      Additionally, MessageEvents have the uid(string), replied_id (integer),
      to (text), cc (text), bcc (text), subject (text) and body (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/message_events', 'Creates a new MessageEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user sending a message to other users.

    #{json_schema(Api::V1::MessageEventRepresenter, include: :writeable)}
  EOS
  def create
    event_create(MessageEvent)
  end

end
