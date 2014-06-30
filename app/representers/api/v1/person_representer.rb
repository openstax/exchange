module Api::V1
  class PersonRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :label, 
             type: String,
             writeable: false,
             schema_info: {
               required: true
             }

  end
end
