require 'rails_helper'

module OpenStax
  module Biglearn
    RSpec.describe V1, type: :external do
      it 'can be configured' do
        configuration = OpenStax::Biglearn::V1.configuration
        expect(configuration).to be_a(OpenStax::Biglearn::V1::Configuration)

        OpenStax::Biglearn::V1.configure do |config|
          expect(config).to eq configuration
        end
      end

      it 'can use the fake client or the real client' do
        initial_client = OpenStax::Biglearn::V1.send :client

        OpenStax::Biglearn::V1.use_fake_client
        expect(OpenStax::Biglearn::V1.send :client).to be_a(OpenStax::Biglearn::V1::FakeClient)

        OpenStax::Biglearn::V1.use_real_client
        expect(OpenStax::Biglearn::V1.send :client).to be_a(OpenStax::Biglearn::V1::RealClient)

        OpenStax::Biglearn::V1.instance_variable_set('@client', initial_client)
      end

      context 'api calls' do
        let!(:client)            { OpenStax::Biglearn::V1.send :client }
        let!(:exercise_activity) { FactoryGirl.create :exercise_activity }
        let!(:identifier)        { exercise_activity.task.identifier }

        let!(:analysis_id) { identifier.analysis_uid }

        let!(:learner_id)  { identifier.read_access_token.token }
        let!(:question_id) {
          uri = URI.parse(exercise_activity.task.resource.url)
          uri.scheme = nil
          uri.to_s
        }
        let!(:score)       { exercise_activity.grade }
        let!(:activity_id) { exercise_activity.id.to_s }
        let!(:timestamp)   { DateTimeUtilities.to_api_s(exercise_activity.updated_at) }

        let!(:learner_args) { {
          platform_learner_id: learner_id,
          analysis_id: analysis_id
        } }

        let!(:response_args) { {
          learner_id: learner_id,
          question_id: question_id,
          score: score,
          activity_id: activity_id,
          timestamp: timestamp
        } }

        it 'delegates send_learner to the client' do
          expect(client).to receive(:send_learner).twice.with(learner_args)

          expect(OpenStax::Biglearn::V1.send_learner(identifier: identifier)).to(
            eq client.send_learner(learner_args)
          )
        end

        it 'delegates send_response to the client' do
          expect(client).to receive(:send_response).twice.with(response_args)

          expect(OpenStax::Biglearn::V1.send_response(exercise_activity: exercise_activity)).to(
            eq client.send_response(response_args)
          )
        end
      end
    end
  end
end
