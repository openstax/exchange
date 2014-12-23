require 'rails_helper'

RSpec.describe Research::BaseController do

  let!(:user) { FactoryGirl.create(:researcher).account }

  it 'shows the researcher dashboard' do
    controller.sign_in user
    get :index
    expect(response).to have_http_status(:success)
  end

end
