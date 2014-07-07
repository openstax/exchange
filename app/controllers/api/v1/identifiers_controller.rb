class Api::V1::IdentifiersController < OpenStax::Api::V1::ApiController

  include Doorkeeper::Helpers::Controller

  resource_description do
    api_versions "v1"
    short_description 'Represents an anonymous student/grader/TA/instructor'
    description <<-EOS
      This controller uses the Client Credentials flow.

      Identifiers represent an anonymous student, grader, TA or instructor.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/identifiers', 'Creates a new Identifier.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates a new Identifier to represent an anonymous user of the platform.

    Callers are only given a 64 hex char access token which
    they can use to create events by that person.

    #{json_schema(Api::V1::IdentifierRepresenter, include: :readable)}
  EOS
  def create
    @identifier = Identifier.new
    @identifier.application = current_application
    @person = Person.new
    @person.platform = Platform.for(current_application)
    @person.identifier = @identifier

    OSU::AccessPolicy.require_action_allowed!(:create, current_api_user, @identifier)
    @person.save! # If this fails, we should get a 422 error

    respond_with @identifier, represent_with: Api::V1::IdentifierRepresenter, status: :created
  end

end
