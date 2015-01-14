module Api::V1
  class EventRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :identifier,
             type: String,
             readable: true,
             writeable: true,
             getter: lambda { |args|
               task.identifier.access_token.try(:token)
             },
             setter: lambda { |value, args|
               task.identifier = Doorkeeper::AccessToken.find_by(token: value)
                                                        .try(:resource_owner)
             },
             schema_info: {
               description: 'The Identifier for the Person associated with this Event'
             }

    property :resource,
             type: String,
             readable: true,
             writeable: true,
             getter: lambda { |args| task.try(:resource).try(:url) },
             setter: lambda { |value, args|
               task.resource = FindOrCreateResourceFromUrl.call(value)
                                 .outputs[:resource]
             },
             schema_info: {
               required: true,
               description: 'The Resource URL associated with this Event'
             }

    property :trial,
             type: String,
             readable: true,
             writeable: true,
             getter: lambda { |args| task.try(:trial) },
             setter: lambda { |value, args|
               task.trial = value
             },
             schema_info: {
               required: true,
               description: 'A unique identifier for the trial ' + \
                            'connected to this Event'
             }

    property :created_at,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The date and time when this Event ' + \
                            'was received by Exchange'
             }

  end
end
