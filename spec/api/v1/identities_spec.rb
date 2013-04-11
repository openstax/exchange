require "spec_helper"

describe "/api/v1/identities", :type => :api do

  let(:exchanger) { FactoryGirl.create(:exchanger_with_api_keys)}

  it "should be creatable by an exchanger with an api key" do
    api_request :post, 'api/v1/identities', exchanger.api_keys.first
    last_response.status.should eql(200)
  end

  
end