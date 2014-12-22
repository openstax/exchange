require 'rails_helper'

module Research
  RSpec.describe BaseController, :type => :routing do
    describe 'routing' do

      it 'routes to #index' do
        expect(:get => '/research').to route_to('research/base#index')
      end

    end
  end
end
