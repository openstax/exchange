module Api::V1
  class EventRepresenter < Roar::Decorator
    include Roar::Representer::JSON

      property :identifier,
               class: String,
               writeable: false,
               schema_info: {
                 required: true,
                 description: 'The identifier for the user associated with this Event'
               }

      property :resource,
               class: String,
               writeable: true,
               schema_info: {
                 required: true,
                 description: 'The Resource associated with this Event'
               }

      property :attempt,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The Attempt associated with this Event'
               }

      property :metadata,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The metadata associated with this Event'
               }

      property :occurred_at,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The date and time when this Event occurred'
               }

  end
end
