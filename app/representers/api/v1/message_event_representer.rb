module Api::V1
  class MessageEventRepresenter < EventRepresenter

    property :uid,
             type: String,
             writeable: true,
             schema_info: {
               description: 'A unique identifier for this message'
             }

    property :replied,
             exec_context: :decorator,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The uid of the message this is a reply to'
             }

    property :to,
             type: String,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The message\'s to field'
             }

    property :cc,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The message\'s cc field'
             }

    property :bcc,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The message\'s bcc field'
             }

    property :subject,
             type: String,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The message\'s subject field'
             }

    property :body,
             type: String,
             writeable: true,
             schema_info: {
               required: true,
               description: 'The message\'s body'
             }

    def replied
      represented.replied.uid
    end

  end
end
