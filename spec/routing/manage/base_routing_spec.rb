require 'rails_helper'

module Manage
  RSpec.describe BaseController, :type => :routing do
    describe 'routing' do

      it 'routes to #index' do
        expect(:get => '/manage').to route_to('manage/base#index')
      end
    end
  end
end
