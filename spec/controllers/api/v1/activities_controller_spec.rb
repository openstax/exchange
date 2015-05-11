require 'rails_helper'

RSpec.describe Api::V1::ActivitiesController, :type => :controller,
                                              :api => true, :version => :v1 do

  let!(:platform)   { FactoryGirl.create :platform }
  let!(:subscriber) { FactoryGirl.create :subscriber }

  let!(:identifier_1) { FactoryGirl.create(:identifier, platform: platform) }
  let!(:identifier_2) { FactoryGirl.create(:identifier, platform: platform) }

  let!(:platform_token)   { FactoryGirl.create :access_token, 
                              application: platform.application }
  let!(:subscriber_token) { FactoryGirl.create :access_token, 
                              application: subscriber.application }
  let!(:account)            { FactoryGirl.create :openstax_accounts_account }
  let!(:researcher_account) { FactoryGirl.create(:researcher).account }

  let!(:resource_1) { FactoryGirl.create :resource }
  let!(:resource_2) { FactoryGirl.create :resource, url: 'dummy://42' }

  let!(:task) { FactoryGirl.create :task, identifier: identifier_1,
                                          resource: resource_1,
                                          trial: 'some_trial' }

  let!(:my_task_1) { FactoryGirl.create :task, resource: resource_2 }
  let!(:my_task_2) { FactoryGirl.create :task, trial: 'another_trial' }

  let!(:my_activity_1) { FactoryGirl.create :reading_activity,
                                            task: my_task_1 }
  let!(:my_activity_2) { FactoryGirl.create :exercise_activity,
                                            task: my_task_2 }
  let!(:my_activity_json) { Api::V1::ActivityRepresenter.new(my_activity_1)
                              .to_json(subscriber: subscriber) }

  before(:each) do
    [:exercise, :feedback, :interactive,
     :peer_grading, :reading].each do |activity_symbol|
      factory_symbol = "#{activity_symbol.to_s}_activity".to_sym
      [identifier_1, identifier_2].each do |identifier|
        (1..5).to_a.each do |i|
          FactoryGirl.create factory_symbol, task: task
        end
      end
    end
  end

  context 'success' do

    it 'should allow subscriber apps to search all activities' do
      api_get :index, subscriber_token, parameters: {q: ''}
      expect(response).to have_http_status(:success)

      output = JSON.parse(response.body)
      expect(output['total_count']).to eq(42)
      expect(output['items'].values.flatten.count).to eq(42)

      api_get :index, subscriber_token, parameters: {q: 'resource:dummy'}
      expect(response).to have_http_status(:success)

      output = JSON.parse(response.body)
      expect(output['total_count']).to eq(1)
      expect(output['items'].values.flatten.count).to eq(1)
      expect(output['items']['reading_activities'].first.to_json).to(
        eq(my_activity_json))
    end

    it 'should allow researchers to search all activities' do
      controller.sign_in researcher_account
      api_get :index, nil, parameters: {q: ''}
      expect(response).to have_http_status(:success)

      output = JSON.parse(response.body)
      expect(output['total_count']).to eq(42)
      expect(output['items'].values.flatten.count).to eq(42)

      api_get :index, nil, parameters: {q: 'resource:dummy'}
      expect(response).to have_http_status(:success)

      output = JSON.parse(response.body)
      expect(output['total_count']).to eq(1)
      expect(output['items'].values.flatten.count).to eq(1)
      expect(output['items']['reading_activities'].first.to_json).to(
        eq(my_activity_json))
    end

    it 'should allow sort by multiple fields in different directions' do
      api_get :index, subscriber_token,
              parameters: {q: '', order_by: 'resource ASC, created_at DESC'}

      output = JSON.parse(response.body)

      expect(output['total_count']).to eq(42)
      expect(output['items'].values.flatten.count).to eq(42)
      expect(output['items']['reading_activities'].first.to_json).to(
        eq(my_activity_json))
    end

  end

  context 'authorization error' do

    it 'should not allow activities to be searched by non-researcher users' do
      controller.sign_in account
      api_get :index, nil, parameters: {q: ''}
      expect(response).to have_http_status(:forbidden)
    end

    it 'should not allow activities to be searched by non-subscriber apps' do
      api_get :index, platform_token, parameters: {q: ''}
      expect(response).to have_http_status(:forbidden)
    end

    it 'should not allow activities to be searched with identifiers' do
      api_get :index, identifier_1.read_access_token, parameters: {q: ''}
      expect(response).to have_http_status(:forbidden)
    end

    it 'should not allow activities to be searched by anonymous' do
      api_get :index, nil, parameters: {q: ''}
      expect(response).to have_http_status(:forbidden)
    end

  end

  context 'validation error' do

    it 'requires the q param' do
      api_get :index, subscriber_token
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

end
