require 'rails_helper'

RSpec.describe StaticPagesController, :type => :routing do
  describe 'routing' do

    it 'routes to #home' do
      expect(:get => '/').to route_to('static_pages#home')
    end

    it 'routes to #about' do
      expect(:get => '/about').to route_to('static_pages#about')
    end

  end
end
