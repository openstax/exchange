module Api::V1
  class MessageEventRepresenter < EventRepresenter

    property :to,
             type: String,
             readable: false,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The message\'s to field'
             }

    property :cc,
             type: String,
             readable: false,
             writeable: true,
             schema_info: {
               description: 'The message\'s cc field'
             }

    property :bcc,
             type: String,
             readable: false,
             writeable: true,
             schema_info: {
               description: 'The message\'s bcc field'
             }

    property :subject,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The message\'s subject field'
             }

    property :body,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The message\'s body'
             }

  end
end
