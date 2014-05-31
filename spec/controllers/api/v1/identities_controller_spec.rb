#
# *** This deprecated file left as an example for the future Exchange developer
#

# require "spec_helper"

# describe Api::V1::IdentitiesController, :type => :api, :version => :v1 do

#   let(:user) { FactoryGirl.create(:user, :is_registered => true) }
#   let(:user_access_token) { FactoryGirl.create(:access_token,
#                                                :resource_owner_id => user.id) }
#   let(:app_access_token) { FactoryGirl.create(:access_token,
#                                               :resource_owner_id => nil) }

#   it "should be creatable by an app with an access token" do
#     api_post :create, app_access_token
#     expect(response.status).to eq(201)

#     expected_response = {
#       :identity => Identity.last.value
#     }.to_json
#     expect(response.body).to eq(expected_response)
#   end

#   it "should not be creatable by a user with an access token" do
#     c = Identity.count
#     expect{api_post :create, user_access_token}.to raise_error(Lev::SecurityTransgression)
#     expect(Identity.count).to eq(c)
#   end

#   it "should not be creatable without an access token" do
#     c = Identity.count
#     expect{api_post :create, nil}.to raise_error(Lev::SecurityTransgression)
#     expect(Identity.count).to eq(c)
#   end

# end