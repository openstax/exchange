class Api::V1::GradingEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents a user\'s work being graded'
    description <<-EOS
      This controller uses the Client Credentials flow.
      The token is obtained by calling the oauth/token endpoint with the application uid,
      secret and a grant_type of "client_credentials."

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, GradingEvents have the grader (string),
      grade (string) and feedback (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/events/platforms/gradings', 'Creates a new GradingEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates an Event that records a user's work being graded.

    Note that the identifier here refers to the user that did the work,
    not the user that graded it.

    #{json_schema(Api::V1::GradingEventRepresenter, include: [:writeable, :app])}
  EOS
  def create
    event_create(GradingEvent) do |e|
      e.person_id = Identifier.where(:token => params[:identifier]).first.resource_owner_id
    end
  end

end
