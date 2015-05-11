require 'rails_helper'

RSpec.describe Api::V1::IdentifiersController, :type => :controller,
                                               :api => true, :version => :v1 do

  let!(:application) { FactoryGirl.create(:application) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:platform_access_token) { FactoryGirl.create(:access_token,
                                                    application: platform.application) }
  let!(:access_token) { FactoryGirl.create(:access_token) }
  let!(:identifier) { FactoryGirl.create(:identifier) }

  context 'success' do

    it 'should be creatable by a platform app with an access token' do
      api_post :create, platform_access_token
      expect(response).to have_http_status(:created)

      expected_response = {
        read: Doorkeeper::AccessToken.order(created_at: :desc).second.token,
        write: Doorkeeper::AccessToken.order(created_at: :desc).first.token
      }.to_json
      expect(response.body).to eq(expected_response)
    end

  end

  context 'authorization error' do

    it 'should not be creatable by a non-platform app' do
      expect{api_post :create, access_token}.not_to change{Doorkeeper::AccessToken.count}
      expect(response).to have_http_status(:forbidden)
    end

    it 'should not be creatable by a user with an access token' do
      expect{api_post :create, identifier.write_access_token}.not_to(
        change{Doorkeeper::AccessToken.count}
      )
      expect(response).to have_http_status(:forbidden)
    end

    it 'should not be creatable without an access token' do
      expect{api_post :create, nil}.not_to change{Doorkeeper::AccessToken.count}
      expect(response).to have_http_status(:unauthorized)
    end

  end

end
