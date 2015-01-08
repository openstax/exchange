require 'rails_helper'

module Api
  module V1
    RSpec.describe AnswerEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create_multiple_choice' do
          expect(:post => '/api/events/platforms/multiple_choices').to(
            route_to('api/v1/answer_events#create_multiple_choice',
                     :format => 'json'))
        end

        it 'routes to #create_free_response' do
          expect(:post => '/api/events/platforms/free_responses').to(
            route_to('api/v1/answer_events#create_free_response',
                     :format => 'json'))
        end

      end
    end
  end
end
