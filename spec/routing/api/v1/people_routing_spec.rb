require 'rails_helper'

module Api
  module V1
    RSpec.describe PeopleController, :type => :routing do
      describe 'routing' do

        it 'routes to #create' do
          expect(:post => '/api/people').to(
            route_to('api/v1/people#create', :format => 'json'))
        end

      end
    end
  end
end
