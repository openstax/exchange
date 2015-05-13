module Api::V1
  class GradingEventRepresenter < EventRepresenter

    property :grader,
             type: String,
             readable: true,
             writeable: true,
             getter: lambda { |args|
               next grader unless args[:activity]

               # If an identifier is submitted as a grader,
               # convert it to an analysis_uid for researchers
               Doorkeeper::AccessToken.find_by(token: grader)
                                      .try(:resource_owner)
                                      .try(:analysis_uid) || grader
             },
             schema_info: {
               description: 'The person, system or algorithm grading this Task'
             }

    property :grade,
             readable: true,
             writeable: true,
             schema_info: {
               description: 'The assigned grade, a decimal number between 0 and 1',
               type: 'number',
               minimum: 0,
               maximum: 1
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
