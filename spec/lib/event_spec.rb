require 'rails_helper'

RSpec.describe Event do

  it 'adds event methods to relevant classes' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_event)
    expect(ActionDispatch::Routing::Mapper.new(Exchange::Application.routes))
      .to respond_to(:event_routes)
  end

  it 'modifies classes that call acts_as_event' do
    heartbeat_event = FactoryGirl.build(:heartbeat_event)
    heartbeat_event.save!
    expect(heartbeat_event.task).to be_an_instance_of(Task)

    heartbeat_event.save!
    heartbeat_event = FactoryGirl.build(:heartbeat_event)
    heartbeat_event.task = nil
    expect(heartbeat_event).not_to be_valid
    expect(heartbeat_event.errors.messages).to(
      include(task: ["can't be blank"])
    )
  end

end
