require 'rails_helper'

RSpec.describe CreateEvent, type: :routine do

  let!(:identifier) { FactoryGirl.create :identifier }
  let!(:resource)   { FactoryGirl.create :resource }
  let!(:trial)      { SecureRandom.hex(32).to_s }

  it 'creates an event and processes it' do
    ProcessEvent.delegate HeartbeatEvent, to: TestProcessor
    result = CreateEvent.call(
      HeartbeatEvent, identifier: identifier, resource: resource, trial: trial
    )
    event = result.outputs[:event]
    expect(event).to be_a(HeartbeatEvent)
    expect(event).to be_persisted
  end

end
