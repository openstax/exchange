class Api::V1::MessageEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user sending a message to other users'
    description <<-EOS
      This controller uses the Client Credentials flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, MessageEvents have the message_id (string), in_reply_to_id (string),
      to (text), cc (text), bcc (text), subject (text) and body (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/events/platforms/messages', 'Creates a new MessageEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records the user sending a message to other users.

    #{json_schema(Api::V1::MessageEventRepresenter, include: [:writeable, :app])}
  EOS
  def create
    event_create(MessageEvent) do |e|
      e.person_id = Identifier.where(:token => params[:identifier])
                              .first.try(:resource_owner_id)
    end
  end

end
