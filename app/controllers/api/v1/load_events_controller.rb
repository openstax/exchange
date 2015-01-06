class Api::V1::LoadEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user visiting a tracked resource'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: platform (object),
      person (object), resource (string) and trial (string).

      Additionally, LoadEvents have the referer (string) field.
    EOS
  end

  api :POST, '/events/identifiers/loads', 'Creates a new LoadEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user opening a Resource page in their browser.

    #{json_schema(Api::V1::LoadEventRepresenter, include: [:writeable, :app])}
  EOS
  def create
    create_event(LoadEvent)
  end

end
