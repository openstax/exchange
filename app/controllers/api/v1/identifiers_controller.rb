class Api::V1::IdentifiersController < OpenStax::Api::V1::ApiController

  skip_before_action :doorkeeper_authorize!
  before_action { doorkeeper_authorize! :write }

  resource_description do
    api_versions "v1"
    short_description 'Represents an anonymous student/grader/TA/instructor'
    description <<-EOS
      This controller uses the Client Credentials flow.

      Identifiers represent anonymous students, graders, TAs or instructors.
    EOS
  end

  api :POST, '/identifiers', 'Creates a new Identifier.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates a new Identifier to represent an anonymous user of the Platform.

    Callers are given a 64 hex char Identifier which
    they can use to create events by that person.

    #{json_schema(Api::V1::IdentifierRepresenter, include: :readable)}
  EOS
  def create
    @result = CreateIdentifier.call(current_application.try(:platform)) do |identifier|
      OSU::AccessPolicy.require_action_allowed!(:create, current_api_user, identifier)
    end

    if @result.errors.empty?
      respond_with @result.outputs[:identifier],
                   represent_with: Api::V1::IdentifierRepresenter,
                   status: :created,
                   location: nil
    else
      render json: @result.errors, status: :unprocessable_entity
    end
  end

end
