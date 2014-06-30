module Api::V1
  class EventRepresenter < Roar::Decorator
    include Roar::Representer::JSON

      property :identifier,
               class: Identifier,
               decorator: IdentifierRepresenter,
               writeable: true,
               schema_info: {
                 required: true,
                 description: "The anonymous user associated with this Event"
               }

      property :resource,
               class: Resource,
               decorator: ResourceRepresenter,
               writeable: true,
               schema_info: {
                 required: true,
                 description: "The Resource associated with this Event"
               }

      property :attempt,
               class: Attempt,
               decorator: AttemptRepresenter,
               writeable: true,
               schema_info: {
                 description: "The Attempt associated with this Event"
               }

      property :metadata,
               class: String,
               writeable: true,
               schema_info: {
                 description: "The metadata associated with this Event"
               }

      property :occurred_at,
               class: String,
               writeable: true,
               schema_info: {
                 description: "The date and time when this Event occurred"
               }

  end
end
