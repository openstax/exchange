module Api::V1
  class IdentifierRepresenter < Roar::Decorator

    include Roar::Representer::JSON

    property :identifier,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| access_token.token },
             schema_info: {
               description: 'The Identifier for this Person; ' + \
                            'Visible only to the Platform that requested it'
             }

  end
end
