require 'rails_helper'

module Api
  module V1
    RSpec.describe CursorEventsController, :type => :routing do
      describe 'routing' do

        it 'routes to #create_mouse_movement' do
          expect(:post => '/api/events/identifiers/mouse_movements').to(
            route_to('api/v1/cursor_events#create_mouse_movement',
                     :format => 'json'))
        end

        it 'routes to #create_mouse_click' do
          expect(:post => '/api/events/identifiers/mouse_clicks').to(
            route_to('api/v1/cursor_events#create_mouse_click',
                     :format => 'json'))
        end

      end
    end
  end
end
