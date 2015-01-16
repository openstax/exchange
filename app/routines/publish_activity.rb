class PublishActivity

  ACTIVITY_TOPICS = {
    'ExerciseActivity' => \
      'arn:aws:sns:us-east-1:665116198742:exercise-activities'
  }

  lev_routine

  protected

  def exec(activity, options={})

    return unless Rails.env.production? || Aws.config[:credentials].set?

    class_name = activity.class.name
    topic_arn = ACTIVITY_TOPICS[class_name]
    return if topic_arn.nil?

    represent_with = options.delete(:represent_with) || \
                     "Api::V1::#{class_name}Representer".constantize \
                       rescue Api::V1::ActivityRepresenter
    message = represent_with.new(activity).to_json
    options = options.merge({ message: message, topic_arn: topic_arn })

    outputs[:result] = Aws::SNS::Client.new.publish options

  end
end
