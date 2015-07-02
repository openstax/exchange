module Api::V1
  class AnswerEventRepresenter < EventRepresenter

    property :answer_type,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The type of answer',
               enum: [ 'multiple-choice', 'free-response' ]
             }

    property :answer,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The answer choice id (for multiple-choice answers) or the answer content (for other types of answers)'
             }

  end
end
