require 'rails_helper'

module Api
  module V1
    RSpec.describe IdentifiersController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/identifiers').to(
            route_to('api/v1/identifiers#create', :format => 'json'))
        end

      end
    end
  end
end
