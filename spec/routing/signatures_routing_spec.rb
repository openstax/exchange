require 'rails_helper'

RSpec.describe SignaturesController, :type => :routing do
  describe 'routing' do

    it 'routes to #new' do
      expect(:get => '/terms/pose').to route_to('signatures#new')
    end

    it 'routes to #create' do
      expect(:post => '/terms/agree').to route_to('signatures#create')
    end

  end
end
