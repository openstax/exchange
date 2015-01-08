require 'rails_helper'

module Api
  module V1
    RSpec.describe HeartbeatEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/heartbeats').to(
            route_to('api/v1/heartbeat_events#create', :format => 'json'))
        end

      end
    end
  end
end
