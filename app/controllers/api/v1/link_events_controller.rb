class Api::V1::LinkEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents a user moving their cursor over a tracked UI object'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: platform (object),
      identifier (string), resource (string) and trial (string).

      Additionally, LinkEvents have the href (string) field.
    EOS
  end

  api :POST, '/events/identifiers/links', 'Creates a new LinkEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user clicking on a link.

    #{json_schema(Api::V1::LinkEventRepresenter, include: :writeable)}
  EOS
  def create
    create_event(LinkEvent)
  end

end
