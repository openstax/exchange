require 'rails_helper'

module Api
  module V1
    RSpec.describe UnloadEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/unloads').to(
            route_to('api/v1/unload_events#create', :format => 'json'))
        end

      end
    end
  end
end
