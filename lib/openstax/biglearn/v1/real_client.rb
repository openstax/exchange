require 'oauth2'

module OpenStax
  module Biglearn
    module V1
      class RealClient

        def initialize(config)
          @server_url = config.server_url
          @client_id = config.client_id
          @secret = config.secret

          @oauth_client = OAuth2::Client.new(@client_id, @secret, site: @server_url)

          @oauth_token = @oauth_client.client_credentials.get_token unless @client_id.nil?
        end

        #
        # API methods
        #

        def send_learner(platform_learner_id:, analysis_id:)
          request_body = {
            learners: [
              platform_learner_id: platform_learner_id,
              analysis_id: analysis_id
            ]
          }.to_json

          uri = URI(@server_url)
          uri.path = "/facts/learners"

          response = request(:post, uri, body: request_body)
          JSON.parse(response.body)
        end

        def send_response(learner_id:, question_id:, score:, activity_id:, timestamp:)
          request_body = {
            learner_id: learner_id,
            question_id: question_id,
            score: score,
            activity_id: activity_id,
            timestamp: timestamp
          }.to_json

          uri = URI(@server_url)
          uri.path = "/facts/responses"

          response = request(:post, uri, body: request_body)
          JSON.parse(response.body)
        end

        protected

        def request(*args)
          (@oauth_token || @oauth_client).request(*args)
        end

      end
    end
  end
end
