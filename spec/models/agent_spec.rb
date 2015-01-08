require 'rails_helper'

RSpec.describe Agent, :type => :model do

  let!(:agent_1) { FactoryGirl.create(:agent) }
  let!(:agent_2) { FactoryGirl.create(:agent, application: agent_1.application) }

  it 'must have an application' do
    agent_1.save!
    agent_1.application = nil
    expect(agent_1).not_to be_valid
    expect(agent_1.errors.messages).to eq(
      :application => ["can't be blank"])
  end

  it 'must have a unique account for each application' do
    agent_2.save!
    agent_2.account = nil
    expect(agent_2).not_to be_valid
    expect(agent_2.errors.messages).to eq(
      :account => ["can't be blank"])

    agent_2.account = agent_1.account
    expect(agent_2.save).to eq(false)
    expect(agent_2.errors.messages).to eq(
      :account => ["has already been taken"])

    agent_2.application = FactoryGirl.create(:application)
    agent_2.save!
  end

end
