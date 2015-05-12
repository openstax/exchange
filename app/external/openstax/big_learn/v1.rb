module OpenStax
  module BigLearn
    class V1

      #
      # API Wrappers
      #

      def self.send_response(exercise_activity:)
        learner_id = exercise_activity.task.identifier.read_access_token.token
        question_id = exercise_activity.task.resource.url
        score = (Float(exercise_activity.grade) rescue 0) >= 1 ? 1 : 0
        activity_id = exercise_activity.id.to_s
        timestamp = DateTimeUtilities.to_api_s(exercise_activity.updated_at)

        begin
          client.send_response(learner_id: learner_id,
                               question_id: question_id,
                               score: score,
                               activity_id: activity_id,
                               timestamp: timestamp)
        rescue ArgumentError => error
          raise error
        rescue StandardError => error
          error_json = JSON.parse(error.message[3..-1]) rescue {}
          raise ArgumentError, error_json['errors'].join(', ') \
            if error_json['message'] == 'invalid input'
          raise ClientError.new(message: "send_response failure", exception: error)
        end
      end

      #
      # Configuration
      #

      def self.configure
        yield configuration
      end

      def self.configuration
        @configuration ||= Configuration.new
      end

      # Accessor for the fake client, which has some extra fake methods on it
      def self.fake_client
        @fake_client ||= FakeClient.instance
      end

      def self.real_client
        @real_client ||= RealClient.new configuration
      end

      def self.use_real_client
        @client = real_client
      end

      def self.use_fake_client
        @client = fake_client
      end

      protected

      def self.client
        begin
          @client ||= fake_client
        rescue StandardError => error
          raise ClientError.new(message: "initialization failure", exception: error)
        end
      end

    end
  end
end
