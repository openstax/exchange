module Api::V1
  class GradingEventRepresenter < EventRepresenter

      property :grader,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'An identifier for the user or algorithm doing the grading'
               }

      property :grade,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'The assigned grade'
               }

      property :feedback,
               class: String,
               writeable: true,
               schema_info: {
                 description: 'Feedback given to the user'
               }

  end
end
