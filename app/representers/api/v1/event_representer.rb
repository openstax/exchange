module Api::V1
  class EventRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :identifier,
             class: Identifier,
             decorator: IdentifierRepresenter,
             writeable: false,
             schema_info: {
               required: true,
               description: 'The identifier for the user associated with this Event'
             }

    property :resource,
             exec_context: :decorator,
             type: String,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The Resource associated with this Event'
             }

    property :attempt,
             exec_context: :decorator,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The Attempt associated with this Event'
             }

    property :metadata,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The metadata associated with this Event'
             }

    property :occurred_at,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The date and time when this Event occurred'
             }

    def resource
      represented.resource.reference
    end

    def attempt
      represented.attempt.try(:reference)
    end

  end
end
