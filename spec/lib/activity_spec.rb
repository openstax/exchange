require 'rails_helper'

RSpec.describe Activity do

  it 'adds activity methods to relevant classes' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_activity)
    expect(ActiveRecord::ConnectionAdapters::TableDefinition.new(
      {}, :test, true, {})).to respond_to(:activity)
    expect(ActiveRecord::Migration.new).to respond_to(:add_activity_indices)
  end

  it 'modifies classes that call acts_as_activity' do
    reading_activity = FactoryGirl.create(:reading_activity)
    expect(reading_activity.platform).to be_an_instance_of(Platform)
    expect(reading_activity.person).to be_an_instance_of(Person)
    expect(reading_activity.resource).to be_an_instance_of(Resource)

    reading_activity.save!
    [:person, :resource, :first_event_at,
     :last_event_at, :seconds_active].each do |attr|
      reading_activity.reload
      reading_activity.send("#{attr.to_s}=", nil)
      expect(reading_activity.save).to eq(false)
      expect(reading_activity.errors.messages).to(
        include(attr => ["can't be blank"])
      )
    end
    reading_activity.reload
    reading_activity.resource.platform = FactoryGirl.create(:platform)
    expect(reading_activity.save).to eq(false)
    expect(reading_activity.errors.messages).to eq(
      :base => ["Activity components refer to different platforms"])
  end

end
