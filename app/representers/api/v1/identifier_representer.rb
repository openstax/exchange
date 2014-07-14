module Api::V1
  class IdentifierRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :token,
             as: :identifier,
             type: String,
             writeable: false,
             schema_info: {
               required: true,
               description: 'Bearer OAuth token to be used to record Events by this user'
             }

  end
end
