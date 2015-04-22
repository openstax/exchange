class PublishActivity

  ACTIVITY_TOPICS = {
    'ExerciseActivity' => \
      'arn:aws:sns:us-east-1:665116198742:exercise-activities'
  }

  CLIENT_OPTIONS = [:stub_responses]

  lev_routine

  protected

  def exec(activity, options = {})
    options[:channels] ||= [:biglearn_api, :sns]

    message = get_message(activity, options)

    publish_to_sns(activity, message, options)
    publish_to_biglearn_api(activity, message, options)
  end

  def get_message(activity, options)
    represent_with = options.delete(:represent_with) || \
                     "Api::V1::#{class_name}Representer".constantize \
                       rescue Api::V1::ActivityRepresenter

    represent_with.new(activity).to_json(activity: true)
  end

  def publish_to_sns(activity, message, options)
    return if !options[:channels].include?(:sns)

    return fatal_error(code: :aws_credentials_blank,
                       message: 'AWS Credentials not set') \
      unless Aws.config[:credentials].set?

    class_name = activity.class.name
    topic_arn = ACTIVITY_TOPICS[class_name]
    return if topic_arn.nil?

    client_options = options.slice(*CLIENT_OPTIONS)
    payload = options.except(*CLIENT_OPTIONS)
                     .merge({ message: message, topic_arn: topic_arn })

    outputs[:sns_result] = Aws::SNS::Client.new(client_options).publish payload
  end

  def publish_to_biglearn_api(activity, message, options)
    return if !options[:channels].include?(:biglearn_api)

  end
end
