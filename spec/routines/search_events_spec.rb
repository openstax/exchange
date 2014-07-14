require 'spec_helper'

describe SearchEvents do

  let!(:platform)   { FactoryGirl.create :platform }
  let!(:subscriber) { FactoryGirl.create :subscriber }

  let!(:identifier_1) { FactoryGirl.create(:identifier, application: platform.application) }
  let!(:identifier_2) { FactoryGirl.create(:identifier, application: platform.application) }

  let!(:resource_1) { FactoryGirl.create :resource, platform: platform }
  let!(:resource_2) { FactoryGirl.create :resource, platform: nil,
                                                    reference: 'Awesome Resource' }

  let!(:my_event_1) { FactoryGirl.create :heartbeat_event, resource: resource_2 }
  let!(:my_event_2) { FactoryGirl.create :page_event, attempt: 4 }

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

  context 'filtering' do

    it 'should return only platform-specific events for platforms' do
      outputs = SearchEvents.call('', platform.application).outputs

      expect(outputs['num_matching_events']).to eq(70)
      expect(outputs['order_by']).to eq 'created_at DESC'
      expect(outputs['events'].values.flatten.count).to eq(70)
      expect(outputs['events'][:heartbeat]).not_to include(my_event_1)
      expect(outputs['events'][:page]).not_to include(my_event_2)
    end

    it 'should return all events for subscribers' do
      outputs = SearchEvents.call('', subscriber.application).outputs

      expect(outputs['num_matching_events']).to eq(72)
      expect(outputs['order_by']).to eq 'created_at DESC'
      expect(outputs['events'].values.flatten.count).to eq(72)
      expect(outputs['events'][:heartbeat]).to include(my_event_1)
      expect(outputs['events'][:page]).to include(my_event_2)
    end

    it 'should partially match some fields' do
      outputs = SearchEvents.call('resource:yRe', subscriber.application).outputs

      expect(outputs['num_matching_events']).to eq(71)
      expect(outputs['order_by']).to eq 'created_at DESC'
      expect(outputs['events'].values.flatten.count).to eq(71)
      expect(outputs['events'][:heartbeat]).not_to include(my_event_1)
      expect(outputs['events'][:page]).to include(my_event_2)
    end

    it 'should exactly match some fields' do
      outputs = SearchEvents.call('attempt:4', subscriber.application).outputs

      expect(outputs['num_matching_events']).to eq(1)
      expect(outputs['order_by']).to eq 'created_at DESC'
      expect(outputs['events'].values.flatten.count).to eq(1)
      expect(outputs['events'][:heartbeat]).not_to include(my_event_1)
      expect(outputs['events'][:page]).to include(my_event_2)
    end

    it 'should match type-specific fields' do
      outputs = SearchEvents.call('y_position:42', subscriber.application).outputs

      expect(outputs['num_matching_events']).to eq(21)
      expect(outputs['order_by']).to eq 'created_at DESC'
      expect(outputs['events'].values.flatten.count).to eq(21)
      expect(outputs['events'][:heartbeat]).to include(my_event_1)
      expect(outputs['events'][:page]).to be_nil
      expect(outputs['events'][:cursor]).not_to be_empty
    end

  end

  context 'sorting' do

    it 'should allow sort by multiple fields in different directions' do
      outputs = SearchEvents.call('', subscriber.application,
                                  order_by: 'resource ASC, created_at DESC').outputs

      expect(outputs['num_matching_events']).to eq(72)
      expect(outputs['order_by']).to eq 'resource ASC, created_at DESC'
      expect(outputs['events'].values.flatten.count).to eq(72)
      expect(outputs['events']['heartbeat'].first).to eq(my_event_1)
    end

  end

end
