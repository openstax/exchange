module Api::V1
  class ExerciseActivityRepresenter < ActivityRepresenter

    collection :answer_events,
               as: :answers,
               class: AnswerEvent,
               decorator: ActivityAnswerEventRepresenter,
               readable: true,
               writeable: false,
               schema_info: {
                 description: 'The given answers'
               }

    property :grade,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The assigned grade'
             }

  end
end
