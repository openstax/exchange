module Api::V1
  class ActivitySearchRepresenter < OpenStax::Api::V1::AbstractSearchRepresenter

    property :total_count,
             inherit: true,
             schema_info: {
               description: 'The number of Activities that match the ' + \
                            'query, can be more than the number returned'
             }

    property :items, schema_info: {
                       description: 'The Activities matching the query ' + \
                                    'or a subset thereof when paginating'
                     } do
      collection :reading_activities,
                 class: ReadingActivity,
                 decorator: ActivityRepresenter,
                 readable: true,
                 writeable: false,
                 schema_info: {
                   description: 'The matching ReadingActivities'
                 }

      collection :exercise_activities,
                 class: ExerciseActivity,
                 decorator: ActivityRepresenter,
                 readable: true,
                 writeable: false,
                 schema_info: {
                   description: 'The matching ExerciseActivities'
                 }

      collection :peer_grading_activities,
                 class: PeerGradingActivity,
                 decorator: ActivityRepresenter,
                 readable: true,
                 writeable: false,
                 schema_info: {
                   description: 'The matching PeerGradingActivities'
                 }

      collection :feedback_activities,
                 class: FeedbackActivity,
                 decorator: ActivityRepresenter,
                 readable: true,
                 writeable: false,
                 schema_info: {
                   description: 'The matching FeedbackActivities'
                 }
    end

  end
end
