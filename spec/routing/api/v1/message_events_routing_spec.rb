require 'rails_helper'

module Api
  module V1
    RSpec.describe MessageEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/platforms/messages').to(
            route_to('api/v1/message_events#create', :format => 'json'))
        end

      end
    end
  end
end
