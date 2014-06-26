class Api::V1::BrowsingEventsController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user visiting a resource'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common:
      identifier (uuid), resource (string), occurred_at (datetime) and metadata (text).

      Additionally, BrowsingEvents have the referer (string) field.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/browsing_events', 'Creates a new BrowsingEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user opening a Resource page in their browser.

    #{json_schema(Api::V1::BrowsingEventRepresenter, include: :writable)}
  EOS
  def create
    @event = standard_create(BrowsingEvent) do |event|
      event.identifier = doorkeeper_token.token
    end
    respond_with @event
  end

end
