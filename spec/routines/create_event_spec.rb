require 'rails_helper'

RSpec.describe CreateEvent do

  let!(:heartbeat_event) { FactoryGirl.build :heartbeat_event,
                             resource: FactoryGirl.create(:resource) }

  it 'creates an event and processes it' do
    ProcessEvent.delegate HeartbeatEvent, to: TestProcessor
    out = CreateEvent.call(HeartbeatEvent, heartbeat_event.attributes).outputs
    event = out[:event]
    test = out[:test]
    expect(event).to be_a(HeartbeatEvent)
    expect(event).to be_persisted
    expect(test).to eq :successful
  end
end
