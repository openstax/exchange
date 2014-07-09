module Api::V1
  class MessageEventRepresenter < EventRepresenter

    property :message_id,
             type: String,
             writeable: true,
             schema_info: {
               description: 'A unique string that identifies this message'
             }

    property :in_reply_to_id,
             exec_context: :decorator,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The id of the message this is a reply to'
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

    def in_reply_to_id
      represented.in_reply_to.message_id
    end

  end
end
