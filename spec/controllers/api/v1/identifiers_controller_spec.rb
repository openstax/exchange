require "spec_helper"

describe Api::V1::IdentifiersController, :type => :controller, :api => true, :version => :v1 do

  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:platform_access_token) { FactoryGirl.create(:access_token,
                                                    application: platform.application) }
  let!(:access_token) { FactoryGirl.create(:access_token) }
  let!(:identifier) { FactoryGirl.create(:identifier) }

  it "should be creatable by a platform app with an access token" do
    api_post :create, platform_access_token
    expect(response.status).to eq(201)

    expected_response = {
      :identifier => Identifier.last.token
    }.to_json
    expect(response.body).to eq(expected_response)
  end

  it "should not be creatable by a non-platform app" do
    c = Identifier.count
    expect{api_post :create, access_token}.to raise_error(SecurityTransgression)
    expect(Identifier.count).to eq(c)
  end

  it "should not be creatable by a user with an access token" do
    c = Identifier.count
    expect{api_post :create, identifier}.to raise_error(SecurityTransgression)
    expect(Identifier.count).to eq(c)
  end

  it "should not be creatable without an access token" do
    c = Identifier.count
    expect{api_post :create, nil}.to raise_error(SecurityTransgression)
    expect(Identifier.count).to eq(c)
  end

end
