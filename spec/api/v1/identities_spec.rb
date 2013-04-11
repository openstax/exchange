require "spec_helper"

describe "/api/v1/identities", :type => :api do

  let(:exchanger) { FactoryGirl.create(:exchanger_with_api_keys)}

  it "should be creatable by an exchanger with an api key" do
    api_request :post, 'api/v1/identities', exchanger.api_keys.first
    last_response.status.should eql(200)

    expected_response = {
      :identity => Identity.last.value
    }.to_json

    last_response.body.should eql(expected_response)
  end

  it "should not be creatable by an exchanger with a bad api key" do
    api_request :post, 'api/v1/identities', 'bad_api_key'
    last_response.status.should eql(401)
  end
  
  it "should not be creatable without api key access" do
    post 'api/v1/identities'
    last_response.status.should eql(401)
  end

end