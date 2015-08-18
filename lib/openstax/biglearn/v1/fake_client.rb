require 'json-schema'

module OpenStax
  module Biglearn
    module V1
      class FakeClient

        include Singleton

        #
        # API methods
        #

        def send_learner(platform_learner_id:, analysis_id:)
          request_body = {
            learners: [
              platform_learner_id: platform_learner_id,
              analysis_id: analysis_id
            ]
          }

          errors = JSON::Validator.fully_validate(
            learners_schema, request_body, insert_defaults: true
          )
          raise ArgumentError, errors.join(', ') unless errors.empty?

          { "message" => "Learners saved." }
        end

        def send_response(learner_id:, question_id:, score:, activity_id:, timestamp:)
          request_body = {
            learner_id: learner_id,
            question_id: question_id,
            score: score,
            activity_id: activity_id,
            timestamp: timestamp
          }

          errors = JSON::Validator.fully_validate(
            response_schema, request_body, insert_defaults: true
          )
          raise ArgumentError, errors.join(', ') unless errors.empty?

          { "message" => "Response saved." }
        end

        protected

        def learners_schema
          <<-EOS
      {
        "$schema": "http://json-schema.org/draft-04/schema#",
        "title": "create-learners-input",
        "description": "Schema of post data for the create learners API",
        "type": "object",
        "properties": {
          "learners": {
            "type": "array",
            "description": "List of learners to be created",
            "items": {
              "type": "object",
              "properties": {
                "platform_learner_id": {
                  "type": "string",
                  "maxLength": 255,
                  "description": "The identifier for a learner that will be used by a platform when querying biglearn."
                },
                "analysis_id": {
                  "type": "string",
                  "maxLength": 255,
                  "description": "The analysis id of the learner that may map to multiple learner platform ids."
                }
              },
              "additionalProperties": false,
              "required": [
                "platform_learner_id",
                "analysis_id"
              ]
            }
          }
        },
        "additionalProperties": false,
        "required": [
          "learners"
        ]
      }
          EOS
        end

        def response_schema
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
