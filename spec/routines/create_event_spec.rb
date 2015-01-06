require 'rails_helper'

RSpec.describe CreateEvent do

  let!(:task) { FactoryGirl.build :task }

  it 'creates an event and processes it' do
    ProcessEvent.delegate HeartbeatEvent, to: TestProcessor
    out = CreateEvent.call(HeartbeatEvent,
                           task.attributes.except('due_at')).outputs
    event = out[:event]
    test = out[:test]
    expect(event).to be_a(HeartbeatEvent)
    expect(event).to be_persisted
    expect(test).to eq :successful
  end

end
