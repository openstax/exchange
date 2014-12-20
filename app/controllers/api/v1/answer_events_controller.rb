class Api::V1::AnswerEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents the user submitting an answer to an exercise'
    description <<-EOS
      This controller uses the Client Credentials flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, AnswerEvents have the answer_type (string) and answer (text) fields.
    EOS
  end

  api :POST, '/events/platforms/multiple_choices', 'Creates a new MultipleChoiceInputEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records the user submitting a multiple choice answer.

    #{json_schema(Api::V1::AnswerEventRepresenter, include: :writeable,
                                                   platform: true)}
  EOS
  def create_multiple_choice
    create_event(AnswerEvent) do |e|
      e.answer_type = 'multiple-choice'
    end
  end

  api :POST, '/events/platforms/free_responses', 'Creates a new FreeResponseInputEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records the user submitting a free response answer.

    #{json_schema(Api::V1::AnswerEventRepresenter, include: :writeable,
                                                   platform: true)}
  EOS
  def create_free_response
    create_event(AnswerEvent) do |e|
      e.answer_type = 'free-response'
    end
  end

end
