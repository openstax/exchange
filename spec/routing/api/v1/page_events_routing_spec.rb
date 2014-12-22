require 'rails_helper'

module Api
  module V1
    RSpec.describe PageEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/pages').to(
            route_to('api/v1/page_events#create', :format => 'json'))
        end

      end
    end
  end
end
