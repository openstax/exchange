class Api::V1::PageEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents the user visiting a web page'
    description <<-EOS
      This controller uses tokens obtained through the Implicit flow.
      This token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, PageEvents have the action (string), from (string)
      and to (string) fields.

      Action is 'load', 'navigate' or 'unload'. Resource is the current page.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/identifiers/events/pages', 'Creates a new PageEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user opening a Resource page in their browser.

    #{json_schema(Api::V1::PageEventRepresenter, include: [:writeable, :app])}
  EOS
  def create
    event_create(PageEvent)
  end

end
