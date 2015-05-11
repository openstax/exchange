module Api::V1
  class ActivityRepresenter < Roar::Decorator

    include Roar::JSON

    property :id,
             type: Integer,
             readable: true,
             writeable: false,
             schema_info: {
               required: true,
               description: 'The id given to this Activity'
             }

    property :platform_id,
             type: Integer,
             readable: true,
             writeable: false,
             getter: lambda { |args| task.identifier.platform_id },
             schema_info: {
               description: 'The ID of the Platform associated with this Activity'
             }

    property :identifier,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| task.identifier.read_access_token.token },
             schema_info: {
               description: 'The read-only identifier for the Person associated with this Activity'
             }

    property :resource,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| task.try(:resource).try(:url) },
             schema_info: {
               required: true,
               description: 'The Resource URL associated with this Activity'
             }

    property :trial,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| task.try(:trial) },
             schema_info: {
               required: true,
               description: 'A unique identifier for the trial ' + \
                            'connected to this Activity'
             }

    property :seconds_active,
             type: Integer,
             readable: true,
             writeable: false,
             schema_info: {
               required: true,
               description: 'The number of seconds the user ' + \
                            'interacted with this Activity'
             }

    property :first_event_at,
             type: DateTime,
             readable: true,
             writeable: false,
             schema_info: {
               required: true,
               description: 'The date and time of the first event ' + \
                            'in this Activity'
             }

    property :last_event_at,
             type: DateTime,
             readable: true,
             writeable: false,
             schema_info: {
               required: true,
               description: 'The date and time of the last event ' + \
                            'in this Activity'
             }

  end
end
