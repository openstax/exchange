require 'rails_helper'

RSpec.describe StandardCreate do

  let!(:heartbeat_event) { FactoryGirl.build :heartbeat_event }

  it 'creates any object' do
    result = StandardCreate.call(HeartbeatEvent,
                                 heartbeat_event.attributes).outputs[:object]
  end

  it 'reports creation errors' do
    heartbeat_event.resource = nil
    errors = StandardCreate.call(HeartbeatEvent,
                                 heartbeat_event.attributes).errors
    expect(errors.first.offending_inputs).to eq(:resource)
    expect(errors.first.code).to eq(:blank)
  end

end
