require 'rails_helper'

RSpec.describe StaticPagesController do

  context 'GET home' do

    it 'renders the home page' do
      get :home
      expect(response).to have_http_status(:success)
    end

  end

  context 'GET about' do

    it 'renders the about page' do
      get :about
      expect(response).to have_http_status(:success)
    end

  end

  context 'GET copyright' do

    it 'renders the copyright page' do
      get :copyright
      expect(response).to have_http_status(:success)
    end

  end

  it 'returns different layouts for home and other actions' do
    controller.action_name = 'home'
    expect(controller.send :resolve_layout).to eq 'application_home_page'

    controller.action_name = 'something_else'
    expect(controller.send :resolve_layout).to eq 'application_body_only'
  end

end
