require 'rails_helper'

module Api
  module V1
    RSpec.describe ClickEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/events/identifiers/clicks').to(
            route_to('api/v1/click_events#create', :format => 'json'))
        end

      end
    end
  end
end
