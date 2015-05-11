module Api::V1
  class IdentifierRepresenter < Roar::Decorator

    include Roar::JSON

    property :read,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| read_access_token.token },
             schema_info: {
               description: 'The Read Identifier for this Person; ' + \
                            'Visible only to the Platform that requested it'
             }

    property :write,
             type: String,
             readable: true,
             writeable: false,
             getter: lambda { |args| write_access_token.token },
             schema_info: {
               description: 'The Write Identifier for this Person; ' + \
                            'Visible only to the Platform that requested it'
             }

  end
end
