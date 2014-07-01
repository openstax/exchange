class Api::V1::MultipleChoiceEventsController < OpenStax::Api::V1::ApiController

  include EventRest

  resource_description do
    api_versions "v1"
    short_description 'Represents the user submitting a multiple choice answer'
    description <<-EOS
      This controller uses the Implicit flow.
      The token is obtained by the platform by creating an Identifier object.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (string), occurred_at (datetime) and metadata (text).

      Additionally, MultipleChoiceInputEvents have the object (string) and data (text) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/multiple_choice_input_events', 'Creates a new MultipleChoiceInputEvent.'
  description <<-EOS
    This API call must be used with the Implicit flow.

    Creates an Event that records the user submitting a multiple choice answer.

    #{json_schema(Api::V1::InputEventRepresenter, include: :writeable)}
  EOS
  def create
    event_create(InputEvent)
  end

end
