require 'rails_helper'

module Api
  module V1
    RSpec.describe InputEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/inputs').to(
            route_to('api/v1/input_events#create', :format => 'json'))
        end

      end
    end
  end
end
