module Api::V1
  class AttemptRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :resource,
             class: Resource,
             decorator: ResourceRepresenter,
             writeable: true,
             schema_info: {
               required: true,
               description: "The Resource associated with this Attempt"
             }

    property :reference, 
             type: String,
             writeable: true,
             schema_info: {
               required: true,
               description: "A unique reference for this Attempt"
             }

  end
end
