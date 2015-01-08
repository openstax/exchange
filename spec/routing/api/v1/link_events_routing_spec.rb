require 'rails_helper'

module Api
  module V1
    RSpec.describe LinkEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/links').to(
            route_to('api/v1/link_events#create', :format => 'json'))
        end

      end
    end
  end
end
