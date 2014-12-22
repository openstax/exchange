require 'rails_helper'

module Api
  module V1
    RSpec.describe GradingEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/platforms/gradings').to(
            route_to('api/v1/grading_events#create', :format => 'json'))
        end

      end
    end
  end
end
