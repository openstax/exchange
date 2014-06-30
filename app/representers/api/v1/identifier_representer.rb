module Api::V1
  class IdentifierRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :access_token, 
             type: String,
             writeable: false,
             schema_info: {
               description: 'OAuth token to be used to record Events by this user',
               required: true
             }

    property :token_type, 
             type: String,
             writeable: false,
             schema_info: {
               description: 'OAuth token type. Always set to "bearer".',
               required: true
             }

  end
end
