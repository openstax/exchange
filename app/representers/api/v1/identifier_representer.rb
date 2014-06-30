module Api::V1
  class IdentifierRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :value, 
             type: String,
             writeable: false,
             schema_info: {
               required: true
             }

  end
end
