module Api::V1
  class MessageInputEventRepresenter < EventRepresenter

      property :uid,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'A unique identifier for this message'
               }

      property :to,
               class: String,
               writeable: true,
               schema_info: {
                 required: true,
                 description: 'The message\'s to field'
               }

      property :cc,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The message\'s cc field'
               }

      property :bcc,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The message\'s bcc field'
               }

      property :subject,
               class: String,
               writeable: true,
               schema_info: {
                 required: true,
                 description: 'The message\'s subject field'
               }

      property :body,
               class: String,
               writeable: true,
               schema_info: {
                 required: true,
                 description: 'The message\'s body'
               }

  end
end
