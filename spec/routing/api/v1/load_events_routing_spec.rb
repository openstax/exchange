require 'rails_helper'

module Api
  module V1
    RSpec.describe LoadEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/loads').to(
            route_to('api/v1/load_events#create', :format => 'json'))
        end

      end
    end
  end
end
