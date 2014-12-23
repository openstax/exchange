require 'rails_helper'

RSpec.describe StaticPagesController do

  it 'shows the home page' do
    get :home
    expect(response).to have_http_status(:success)
  end

  it 'shows the copyright page' do
    get :copyright
    expect(response).to have_http_status(:success)
  end

end
