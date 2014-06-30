module Api::V1
  class ResourceRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :reference, 
             type: String,
             writeable: true,
             schema_info: {
               required: true,
               description: "A unique reference for this Resource"
             }

  end
end
