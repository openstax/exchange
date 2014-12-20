class Api::V1::PeopleController < OpenStax::Api::V1::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents an anonymous student/grader/TA/instructor'
    description <<-EOS
      This controller uses the Client Credentials flow.

      Persons represent anonymous students, graders, TAs or instructors.
    EOS
  end

  api :POST, '/people', 'Creates a new Person.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.

    Creates a new Person to represent an anonymous user of the platform.

    Callers are given a 64 hex char Identifier which
    they can use to create events by that person.

    #{json_schema(Api::V1::PersonRepresenter, include: :readable,
                                              platform: true)}
  EOS
  def create
    @person = Person.new
    @person.identifiers << Doorkeeper::AccessToken.new(
      application: current_application
    )

    OSU::AccessPolicy.require_action_allowed!(
      :create, current_api_user, @person
    )

    @person.save! # If this fails, we should get a 422 error

    respond_with @person, represent_with: Api::V1::PersonRepresenter,
                          status: :created,
                          platform: current_application.platform
  end

end
