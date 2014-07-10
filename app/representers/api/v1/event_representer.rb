module Api::V1
  class EventRepresenter < Roar::Decorator
    include Roar::Representer::JSON
    include Event::Decorator

    property :id,
             type: Integer,
             writeable: false,
             schema_info: {
               description: 'The id given to this Event'
             }

    identifier_or_person_property

    property :selector,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The selector for the object that triggered this Event'
             }

    property :resource,
             getter: lambda { |args| resource.try(:reference) },
             setter: lambda { |val, args| self.resource = Resource.find_or_create(
                                Platform.for(args[:requestor]), val) },
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               required: true,
               description: 'The Resource associated with this Event'
             }

    property :attempt,
             type: Integer,
             writeable: true,
             simple: true,
             schema_info: {
               required: true,
               description: 'The attempt number associated with this Event'
             }

    property :metadata,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The metadata associated with this Event'
             }

    property :created_at,
             type: String,
             writeable: false,
             schema_info: {
               description: 'The date and time when this Event was sent to Exchange'
             }

  end
end
