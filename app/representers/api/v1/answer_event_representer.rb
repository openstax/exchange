module Api::V1
  class AnswerEventRepresenter < EventRepresenter

    property :answer_type,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The type of answer'
             }

    property :answer,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The answer content'
             }

  end
end
