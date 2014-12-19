module Api::V1
  class EventRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :person,
             class: Person,
             decorator: PersonRepresenter,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The Person associated with this Event'
             }


    property :resource,
             type: String,
             readable: true,
             writeable: true,
             skip_parse: lambda { |fragment, args| !args[:platform] },
             getter: lambda { |args| resource.try(:reference) },
             setter: lambda { |value, args|
               self.resource = Resource.find_or_create_by(
                 platform: args[:platform],
                 reference: value) },
             schema_info: {
               required: true,
               description: 'The Resource String associated with this Event'
             }

    property :attempt,
             type: Integer,
             readable: true,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The attempt number associated with this Event'
             }

    property :selector,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The selector for the object ' + \
                            'that triggered this Event'
             }

    property :created_at,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The date and time when this Event ' + \
                            'received by Exchange'
             }

  end
end
