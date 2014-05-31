module Api::V1
  class IdentityRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :value, as: :identity,
             type: String,
             writeable: false,
             readable: true,
             schema_info: {
               required: true
             }

  end
end
