module Api::V1
  class ActivityAnswerEventRepresenter < ActivityEventRepresenter

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
               description: 'The answer content'
             }

  end
end
