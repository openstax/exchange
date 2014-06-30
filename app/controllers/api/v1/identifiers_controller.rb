class Api::V1::IdentifiersController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents an anonymous student/grader/TA/instructor'
    description <<-EOS
      This controller uses the Client Credentials flow.

      Identifiers represent an anonymous student, grader, TA or instructor.

      They only have a unique, random 16 byte id and a person_id field.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/identifiers', 'Creates a new Identifier.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates a new Identifier to represent an anonymous user of the platform.

    #{json_schema(Api::V1::IdentifiertRepresenter, include: :writable)}
  EOS
  def create
    @identifier = standard_create(Identifier)
    respond_with @identifier
  end

end
