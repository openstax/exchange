module Api::V1
  class EventRepresenter < Roar::Decorator
    include Roar::Representer::JSON

    property :id,
             type: Integer,
             writeable: false,
             schema_info: {
               description: 'The id given to this Event'
             }

    property :identifier,
             exec_context: :decorator,
             type: String,
             writeable: false,
             schema_info: {
               description: 'The identifier for the user associated with this Event; Visible only to Platforms'
             }

    property :person,
             class: Person,
             decorator: PersonRepresenter,
             writeable: false,
             schema_info: {
               description: 'The researh label for the user associated with this Event; Visible only to Subscribers and Researchers'
             }

    property :resource,
             exec_context: :decorator,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               required: true,
               description: 'The Resource associated with this Event'
             }

    property :attempt,
             exec_context: :decorator,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The Attempt associated with this Event'
             }

    property :metadata,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The metadata associated with this Event'
             }

    property :occurred_at,
             type: String,
             writeable: true,
             simple: true,
             schema_info: {
               description: 'The date and time when this Event occurred'
             }

    def identifier
      represented.identifier.token
    end

    def resource
      represented.resource.reference
    end

    def attempt
      represented.attempt.try(:reference)
    end

  end
end
