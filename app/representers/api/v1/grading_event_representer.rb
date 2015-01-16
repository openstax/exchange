module Api::V1
  class GradingEventRepresenter < EventRepresenter

    property :grader,
             type: String,
             readable: true,
             writeable: true,
             getter: lambda { |args|
               next grader unless args[:activity]

               # If an identifier is submitted as a grader,
               # convert it to a research_label for researchers
               Doorkeeper::AccessToken.find_by(token: grader)
                                      .try(:resource_owner)
                                      .try(:research_label) || grader
             },
             schema_info: {
               description: 'The person grading this Task'
             }

    property :grade,
             type: String,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The assigned grade'
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
