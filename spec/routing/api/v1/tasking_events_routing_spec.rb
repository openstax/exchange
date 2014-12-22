require 'rails_helper'

module Api
  module V1
    RSpec.describe AnswerEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/platforms/taskings').to(
            route_to('api/v1/tasking_events#create', :format => 'json'))
        end

      end
    end
  end
end
