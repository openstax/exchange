require 'rails_helper'

RSpec.describe Manage::BaseController do

  let!(:user) { FactoryGirl.create(:agent).account }

  it 'shows the manager dashboard' do
    controller.sign_in user
    get :index
    expect(response).to have_http_status(:success)
  end

end
