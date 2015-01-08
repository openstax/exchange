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
    expect(reading_activity.task).to be_an_instance_of(Task)

    reading_activity.save!
    [:task, :first_event_at, :last_event_at, :seconds_active].each do |attr|
      reading_activity.reload
      reading_activity.send("#{attr.to_s}=", nil)
      expect(reading_activity).not_to be_valid
      expect(reading_activity.errors.messages).to(
        include(attr => ["can't be blank"])
      )
    end
  end

end
