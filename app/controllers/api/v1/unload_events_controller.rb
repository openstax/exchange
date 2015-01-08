class Api::V1::UnloadEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user visiting a tracked resource'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: platform (object),
      identifier (string), resource (string) and trial (string).

      Additionally, UnloadEvents have the destination (string) field.
    EOS
  end

  api :POST, '/events/identifiers/unloads', 'Creates a new UnloadEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user opening a Resource page in their browser.

    #{json_schema(Api::V1::UnloadEventRepresenter, include: :writeable)}
  EOS
  def create
    create_event(UnloadEvent)
  end

end
