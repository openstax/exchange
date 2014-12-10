class Api::V1::InputEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user inputting information into a form or similar'
    description <<-EOS
      This controller uses either Implicit or Client Credential tokens.
      Implicit tokens are obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, InputEvents have the input_type (string) and value (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/events/identifiers/inputs', 'Creates a new InputEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user inputting information into a form or similar.

    #{json_schema(Api::V1::InputEventRepresenter, include: :writeable)}
  EOS
  def create
    raise SecurityTransgression if current_api_user.human_user.nil?
    create_event(InputEvent) do |e|
      e.category = 'user'
    end
  end

  api :POST, '/events/platforms/multiple_choices', 'Creates a new MultipleChoiceInputEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records the user submitting a multiple choice answer.

    #{json_schema(Api::V1::InputEventRepresenter, include: [:simple, :app])}
  EOS
  def create_multiple_choice
    raise SecurityTransgression unless current_api_user.human_user.nil?
    create_event(InputEvent) do |e|
      e.person_id = Identifier.where(:token => params[:identifier])
                              .first.try(:resource_owner_id)
      e.category = 'multiple_choice'
      e.input_type = 'radio'
    end
  end

  api :POST, '/events/platforms/free_responses', 'Creates a new FreeResponseInputEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records the user submitting a free response answer.

    #{json_schema(Api::V1::InputEventRepresenter, include: [:simple, :app])}
  EOS
  def create_free_response
    raise SecurityTransgression unless current_api_user.human_user.nil?
    create_event(InputEvent) do |e|
      e.person_id = Identifier.where(:token => params[:identifier])
                              .first.try(:resource_owner_id)
      e.category = 'free_response'
      e.input_type = 'text'
    end
  end

end
