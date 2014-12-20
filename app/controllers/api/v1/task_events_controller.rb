class Api::V1::TaskEventsController < OpenStax::Api::V1::ApiController

  include Event::ApiController

  resource_description do
    api_versions "v1"
    short_description 'Represents a task being assigned to a user'
    description <<-EOS
      This controller uses a token obtained through the Client Credentials flow.

      All events have the following fields in common: identifier (string),
      resource (string), attempt (integer), selector (string) and metadata (text).

      Additionally, TaskEvents have the task (string), assigner (string),
      due_date (datetime) and status (string) fields.
    EOS
  end

  ###############################################################
  # create
  ###############################################################

  api :POST, '/events/platforms/tasks', 'Creates a new TaskEvent.'
  description <<-EOS
    This API call must be used with the Client Credentials flow.
    You must supply an identifier token in the URL, with the 'identifier' key.

    Creates an Event that records or updates a task assignment.

    #{json_schema(Api::V1::TaskEventRepresenter, include: [:writeable, :app])}
  EOS
  def create
    create_event(TaskEvent) do |e|
      e.person_id = Identifier.where(:token => params[:identifier])
                              .first.try(:resource_owner_id)
    end
  end

end
