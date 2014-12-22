require 'rails_helper'

RSpec.describe TermsController, :type => :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/terms').to route_to('terms#index')
    end

    it 'routes to #show' do
      expect(:get => '/terms/1').to route_to('terms#show', :id => '1')
    end

  end
end
