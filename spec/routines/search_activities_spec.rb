require 'rails_helper'

RSpec.describe SearchActivities do

  let!(:platform)   { FactoryGirl.create :platform }
  let!(:subscriber) { FactoryGirl.create :subscriber }

  let!(:identifier_1) { FactoryGirl.create(:identifier, platform: platform) }
  let!(:identifier_2) { FactoryGirl.create(:identifier, platform: platform) }

  let!(:resource_1) { FactoryGirl.create :resource }
  let!(:resource_2) { FactoryGirl.create :resource, url: 'dummy://42' }

  let!(:task_1) { FactoryGirl.create :task, resource: resource_2 }
  let!(:task_2) { FactoryGirl.create :task, trial: 'some_trial' }

  let!(:my_activity_1) { FactoryGirl.create :reading_activity, task: task_1 }
  let!(:my_activity_2) { FactoryGirl.create :exercise_activity, task: task_2 }

  before(:each) do
    skip
    [:exercise, :feedback, :interactive,
     :peer_grading, :reading].each do |activity_symbol|
      factory_symbol = "#{activity_symbol.to_s}_activity".to_sym
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

    it 'should return only platform-specific activities for platforms' do
      outputs = SearchActivities.call('', platform.application).outputs

      expect(outputs['total_count']).to eq(70)
      expect(outputs['items'].values.flatten.count).to eq(70)
      expect(outputs['items']['reading']).not_to include(my_activity_1)
      expect(outputs['items']['exercise']).not_to include(my_activity_2)
    end

    it 'should return all activities for subscribers' do
      outputs = SearchActivities.call('', subscriber.application).outputs

      expect(outputs['total_count']).to eq(72)
      expect(outputs['items'].values.flatten.count).to eq(72)
      expect(outputs['items']['reading']).to include(my_activity_1)
      expect(outputs['items']['exercise']).to include(my_activity_2)
    end

    it 'should partially match fields' do
      outputs = SearchActivities.call('resource:yRe', subscriber.application)
                                .outputs

      expect(outputs['total_count']).to eq(71)
      expect(outputs['items'].values.flatten.count).to eq(71)
      expect(outputs['items']['reading']).not_to include(my_activity_1)
      expect(outputs['items']['exercise']).to include(my_activity_2)

      outputs = SearchActivities.call('trial:e_tri', subscriber.application)
                                .outputs

      expect(outputs['total_count']).to eq(1)
      expect(outputs['items'].values.flatten.count).to eq(1)
      expect(outputs['items']['reading']).not_to include(my_activity_1)
      expect(outputs['items']['exercise']).to include(my_activity_2)
    end

    it 'should match type-specific fields' do
      outputs = SearchActivities.call('answer_type:multiple_choice',
                                      subscriber.application).outputs

      expect(outputs['total_count']).to eq(21)
      expect(outputs['items'].values.flatten.count).to eq(21)
      expect(outputs['items']['reading']).to be_nil
      expect(outputs['items']['exercise']).to include(my_event_1)
    end

  end

  context 'sorting' do

    it 'should allow sort by multiple fields in different directions' do
      outputs = SearchActivities.call(
        '', subscriber.application, order_by: 'resource ASC, created_at DESC'
      ).outputs

      expect(outputs['total_count']).to eq(72)
      expect(outputs['items'].values.flatten.count).to eq(72)
      expect(outputs['items']['reading'].first).to eq(my_activity_1)
    end

  end

end
