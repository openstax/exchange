module Api::V1
  class ExerciseActivityRepresenter < ActivityRepresenter

    collection :answer_events,
               as: :answers,
               class: AnswerEvent,
               decorator: AnswerEventRepresenter,
               readable: true,
               writeable: false,
               activity: true,
               schema_info: {
                 description: 'The given answers'
               }

    collection :grading_events,
               as: :gradings,
               class: AnswerEvent,
               decorator: GradingEventRepresenter,
               readable: true,
               writeable: false,
               activity: true,
               schema_info: {
                 description: 'The grades assigned by each grader'
               }

    property :grade,
             type: String,
             readable: true,
             writeable: false,
             schema_info: {
               description: 'The final grade for the Task'
             }

  end
end
