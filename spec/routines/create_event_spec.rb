require 'rails_helper'

RSpec.describe CreateEvent do

  let!(:platform) { FactoryGirl.build :platform }
  let!(:resource) { FactoryGirl.build(:resource) }
  let!(:person)   { FactoryGirl.build :person }
  let!(:trial)    { SecureRandom.hex(32).to_s }

  it 'creates an event and processes it' do
    ProcessEvent.delegate HeartbeatEvent, to: TestProcessor
    out = CreateEvent.call(
      HeartbeatEvent, platform: platform, resource: resource,
                      person: person, trial: trial
    ).outputs
    event = out[:event]
    expect(event).to be_a(HeartbeatEvent)
    expect(event).to be_persisted
  end

end
