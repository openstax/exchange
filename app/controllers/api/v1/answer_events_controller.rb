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

  api :POST, '/events/platforms/answers', 'Creates a new AnswerEvent.'
  description <<-EOS
    Creates an Event that records the user submitting an answer to an exercise.

    #{json_schema(Api::V1::AnswerEventRepresenter, include: :writeable,
                                                   platform: true)}
  EOS
  def create
    event_create(AnswerEvent)
  end

end
