require 'rails_helper'

RSpec.describe CreateTask do

  let!(:platform) { FactoryGirl.build :platform }
  let!(:resource) { FactoryGirl.build(:resource).url }
  let!(:person)   { FactoryGirl.build :person }
  let!(:trial)    { SecureRandom.hex(32).to_s }

  it 'creates a task' do
    out = CreateTask.call(platform: platform, resource: resource,
                          person: person, trial: trial).outputs
    task = out[:task]
    test = out[:test]
    expect(task).to be_a(Task)
    expect(task).to be_persisted
    expect(test).to eq :successful
  end

end
