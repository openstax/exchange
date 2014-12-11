require 'rails_helper'

describe Api::V1::EventsController, :type => :controller, :api => true, :version => :v1 do

  let!(:platform)   { FactoryGirl.create :platform }
  let!(:subscriber) { FactoryGirl.create :subscriber }

  let!(:identifier_1) { FactoryGirl.create(:identifier, application: platform.application) }
  let!(:identifier_2) { FactoryGirl.create(:identifier, application: platform.application) }

  let!(:platform_token)   { FactoryGirl.create :access_token, 
                                               application: platform.application }
  let!(:subscriber_token) { FactoryGirl.create :access_token, 
                                               application: subscriber.application }

  let!(:resource_1) { FactoryGirl.create :resource, platform: platform }
  let!(:resource_2) { FactoryGirl.create :resource, platform: nil,
                                                    reference: 'Awesome Resource' }

  let!(:my_event_1) { FactoryGirl.create :heartbeat_event, resource: resource_2 }
  let!(:my_event_2) { FactoryGirl.create :heartbeat_event }
  let!(:my_event_json) { Api::V1::HeartbeatEventRepresenter.new(my_event_1)
                           .to_json(requestor: subscriber.application) }

  before(:each) do
    [:page, :heartbeat, :cursor,
     :input, :task, :grading, :message].each do |event_symbol|
      factory_symbol = "#{event_symbol.to_s}_event".to_sym
      [identifier_1, identifier_2].each do |identifier|
        (1..5).to_a.each do |i|
          FactoryGirl.create factory_symbol, platform: platform,
                             person: identifier.resource_owner,
                             resource: resource_1
        end
      end
    end
  end

  context 'success' do

    it 'should allow platforms to search their own events' do
      api_get :index, platform_token, parameters: {q: ''}
      expect(response.code).to eq('200')

      output = JSON.parse(response.body)
      expect(output['num_matching_events']).to eq(70)
      expect(output['order_by']).to eq('created_at DESC')
      expect(output['events'].values.flatten.count).to eq(70)

      api_get :index, platform_token, parameters: {q: 'resource:me'}
      expect(response.code).to eq('200')

      output = JSON.parse(response.body)
      expect(output['num_matching_events']).to eq(0)
      expect(output['order_by']).to eq('created_at DESC')
      expect(output['events'].values.flatten).to be_empty
    end

    it 'should allow subscribers to search all events' do
      api_get :index, subscriber_token, parameters: {q: ''}
      expect(response.code).to eq('200')

      output = JSON.parse(response.body)
      expect(output['num_matching_events']).to eq(72)
      expect(output['order_by']).to eq('created_at DESC')
      expect(output['events'].values.flatten.count).to eq(72)

      api_get :index, subscriber_token, parameters: {q: 'resource:me'}
      expect(response.code).to eq('200')

      output = JSON.parse(response.body)
      expect(output['num_matching_events']).to eq(1)
      expect(output['order_by']).to eq('created_at DESC')
      expect(output['events'].values.flatten.count).to eq(1)
      expect(output['events']['heartbeat'].first.to_json).to eq(my_event_json)
    end

    it 'should allow sort by multiple fields in different directions' do
      api_get :index, subscriber_token,
              parameters: {q: '', order_by: 'resource ASC, created_at DESC'}

      output = JSON.parse(response.body)

      expect(output['num_matching_events']).to eq(72)
      expect(output['order_by']).to eq 'resource ASC, created_at DESC'
      expect(output['events'].values.flatten.count).to eq(72)
      expect(output['events']['heartbeat'].first.to_json).to eq(my_event_json)
    end

  end

  context 'authorization error' do

    it 'should not allow events to be searched with identifiers' do
      expect{api_get :index, identifier_1, parameters: {q: ''}}.to(
        raise_error(SecurityTransgression))

      expect(response.body).to be_empty
    end

    it 'should not allow events to be searched without a token' do
      expect{api_get :index, nil, parameters: {q: ''}}.to(
        raise_error(SecurityTransgression))

      expect(response.body).to be_empty
    end

  end

  context 'validation error' do

    it 'requires the q param' do
      expect{api_get :index, identifier_1}.to(
        raise_error(Apipie::ParamMissing))

      expect(response.body).to be_empty
    end

  end

end
