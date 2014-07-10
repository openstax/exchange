module Api::V1
  class GradingEventRepresenter < EventRepresenter

    identifier_or_person_property :grader

    property :grade,
             type: String,
             writeable: true,
             schema_info: {
               description: 'The assigned grade'
             }

    property :feedback,
             type: String,
             writeable: true,
             schema_info: {
               description: 'Feedback given to the user'
             }

  end
end
