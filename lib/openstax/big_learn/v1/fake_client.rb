require 'json-schema'

module OpenStax
  module BigLearn
    module V1
      class FakeClient

        include Singleton

        #
        # API methods
        #

        def send_response(learner_id:, question_id:, score:, activity_id:, timestamp:)
          request_body = {
            learner_id: learner_id,
            question_id: question_id,
            score: score,
            activity_id: activity_id,
            timestamp: timestamp
          }

          errors = JSON::Validator.fully_validate(schema, request_body, insert_defaults: true)
          raise ArgumentError, errors.join(', ') unless errors.empty?

          { "message" => "Response saved." }
        end

        protected

        def schema
          <<-EOS
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "title": "create-response-input",
        "description": "Schema of post data for creating a new response in biglearn.",
        "type": "object",
        "properties": {
          "learner_id": {
            "type": "string",
            "description": "The unique id of the learner.  Accepts the platform id as well as analysis id.",
            "maxLength": 255
          },
          "question_id": {
            "type": "string",
            "description": "The unique id of the responded question. For example: quadbase_qid.",
            "maxLength": 255
          },
          "score": {
            "type": "number",
            "description": "The credit received by the learner.  While this is not enforced by the API, the current expectation is that this would be a boolean value (0 or 1) denoting incorrect vs correct.",
            "minimum": 0,
            "maximum": 1
          },
          "activity_id": {
            "type": "string",
            "description": "The unique id of an activity that this question was part of.  For example: practice_session_id, exam_id.",
            "maxLength": 255
          },
          "timestamp": {
            "type": "string",
            "format": "date-time",
            "description": "The timestamp when the question was answered. Expects a valid RFC3339 date time string.",
            "maxLength": 25
          }
        },
        "additionalProperties": false,
        "required": [
          "learner_id",
          "question_id",
          "score",
          "activity_id",
          "timestamp"
        ]
      }
          EOS
        end

      end
    end
  end
end
