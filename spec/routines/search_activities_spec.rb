require 'rails_helper'

RSpec.describe SearchActivities, type: :routine do

  let!(:platform)   { FactoryGirl.create :platform }
  let!(:subscriber) { FactoryGirl.create :subscriber }

  let!(:identifier_1) { FactoryGirl.create(:identifier, platform: platform) }
  let!(:identifier_2) { FactoryGirl.create(:identifier, platform: platform) }

  let!(:resource_1) { FactoryGirl.create :resource }
  let!(:resource_2) { FactoryGirl.create :resource, url: 'dummy://42' }

  let!(:my_task_1) { FactoryGirl.create :task, resource: resource_2 }
  let!(:my_task_2) { FactoryGirl.create :task, trial: 'another_trial' }

  let!(:my_activity_1) { FactoryGirl.create :reading_activity,
                                            task: my_task_1 }
  let!(:my_activity_2) { FactoryGirl.create :exercise_activity,
                                            task: my_task_2 }

  before(:each) do
    [identifier_1, identifier_2].each do |identifier|
      (1..5).to_a.each do |i|
        task = FactoryGirl.create :task, identifier: identifier,
                                         resource: resource_1,
                                         trial: "Trial #{i}"
        [:reading, :exercise, :peer_grading, :feedback].each do |activity_symbol|
          factory_symbol = "#{activity_symbol.to_s}_activity".to_sym
          FactoryGirl.create factory_symbol, task: task
        end
      end
    end
  end

  context 'filtering' do

    it 'should return all activities' do
      outputs = SearchActivities.call(query: '').outputs

      expect(outputs['total_count']).to eq(42)
      expect(outputs['items'].values.flatten.count).to eq(42)
      expect(outputs['items']['reading_activities']).to include(my_activity_1)
      expect(outputs['items']['exercise_activities']).to include(my_activity_2)
    end

    it 'should partially match fields' do
      outputs = SearchActivities.call(query: 'resource:"ummy://4"').outputs

      expect(outputs['total_count']).to eq(1)
      expect(outputs['items'].values.flatten.count).to eq(1)
      expect(outputs['items']['reading_activities']).to include(my_activity_1)
      expect(outputs['items']['exercise_activities']).not_to(
        include(my_activity_2))

      outputs = SearchActivities.call(query: 'trial:other_tri').outputs

      expect(outputs['total_count']).to eq(1)
      expect(outputs['items'].values.flatten.count).to eq(1)
      expect(outputs['items']['reading_activities']).not_to(
        include(my_activity_1))
      expect(outputs['items']['exercise_activities']).to include(my_activity_2)
    end

  end

  context 'sorting' do

    it 'should allow sort by multiple fields in different directions' do
      outputs = SearchActivities.call(
        query: '', order_by: 'resource ASC, created_at DESC'
      ).outputs

      expect(outputs['total_count']).to eq(42)
      expect(outputs['items'].values.flatten.count).to eq(42)
      expect(outputs['items']['reading_activities'].first).to eq(my_activity_1)
    end

  end

end
