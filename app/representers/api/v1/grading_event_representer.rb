module Api::V1
  class GradingEventRepresenter < EventRepresenter

    property :grader,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'Who graded this Task'
             }

    property :grade,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The grade assigned to the given Resource'
             }

    property :feedback,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'Feedback given with the grade'
             }

  end
end
