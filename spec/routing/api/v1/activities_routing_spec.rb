require 'rails_helper'

module Api
  module V1
    RSpec.describe ActivitiesController, :type => :routing do
      describe 'routing' do

        it 'routes to #index' do
          expect(:get => '/api/activities').to(
            route_to('api/v1/activities#index', :format => 'json'))
        end

      end
    end
  end
end
