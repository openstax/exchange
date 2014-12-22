class Api::V1::TaskingEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents a task being assigned to a user'
    description <<-EOS
      This controller uses a token obtained through the Client Credentials flow.

      All events have the following fields in common: platform (object),
      person (object), resource (string) and context (string).

      Additionally, TaskingEvents have the assignee (string) and
      due_date (datetime) fields.
    EOS
  end

  api :POST, '/events/platforms/taskings', 'Creates a new TaskingEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records or updates a task assignment.

    #{json_schema(Api::V1::TaskingEventRepresenter, include: :writeable,
                                                    platform: true)}
  EOS
  def create
    create_event(TaskingEvent)
  end

end
