module Api::V1
  class ActivityRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :id,
             type: Integer,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The id given to this Activity'
             }

    property :person,
             class: Person,
             decorator: PersonRepresenter,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The Person associated with this Activity'
             }

    property :resource,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| resource.try(:reference) },
             schema_info: {
               required: true,
               description: 'The Resource String associated with this Activity'
             }

    property :attempt,
             type: Integer,
             readable: true,
             writeable: false,
             schema_info: {
               required: true,
               description: 'The attempt number associated with this Activity'
             }

    property :seconds_active,
             type: Integer,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The number of seconds the user ' + \
                            'interacted with this Activity'
             }

    property :first_event_at,
             type: DateTime,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The date and time of the first event ' + \
                            'in this Activity'
             }

    property :last_event_at,
             type: DateTime,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The date and time of the last event ' + \
                            'in this Activity'
             }

  end
end
