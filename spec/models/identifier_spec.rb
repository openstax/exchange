require 'rails_helper'

describe Identifier, :type => :model do

  let!(:identifier_1) { FactoryGirl.create(:identifier) }
  let!(:identifier_2) { FactoryGirl.create(:identifier,
                                           application: identifier_1.application) }

  before(:each) do
    FactoryGirl.create(:platform, application: identifier_1.application)
  end

  it 'must have a resource_owner and a platform application or no resource_owner' do
    identifier_1.save!
    identifier_1.application = FactoryGirl.create(:application)
    expect(identifier_1.save).to eq(false)
    expect(identifier_1.errors.messages).to eq(
      :application => ['Only Platforms can obtain Identifiers'])
    identifier_1.resource_owner = nil
    identifier_1.save!
  end

  it 'must have a unique resource_owner, if present' do
    identifier_2.save!
    identifier_2.resource_owner = identifier_1.resource_owner
    expect(identifier_2.save).to eq(false)
    expect(identifier_2.errors.messages).to eq(
      :resource_owner_id => ['has already been taken'])
  end

end
