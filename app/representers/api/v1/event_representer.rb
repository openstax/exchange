module Api::V1
  class EventRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :id,
             type: Integer,
             writeable: false,
             schema_info: {
               description: 'The id given to this Event'
             }

    property :identifier,
             getter: lambda { |args| Platform.for(args[:requestor]) ? \
                                       identifier.token : nil },
             type: String,
             writeable: false,
             app: true,
             schema_info: {
               description: 'The identifier for the user associated with this Event; Visible only to Platforms'
             }

    property :person,
             getter: lambda { |args| (Subscriber.for(args[:requestor]) ||\
                                      Researcher.for(args[:requestor])) ? \
                                       person : nil },
             class: Person,
             decorator: PersonRepresenter,
             writeable: false,
             schema_info: {
               description: 'The researh label for the user associated with this Event; Visible only to Subscribers and Researchers'
             }

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
