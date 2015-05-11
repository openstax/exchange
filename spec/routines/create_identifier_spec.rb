require 'rails_helper'

RSpec.describe CreateIdentifier do

  let!(:platform) { FactoryGirl.create :platform }

  it 'creates an Identifier with a new Person and an AccessToken' do
    pc = Person.count
    atc = Doorkeeper::AccessToken.count
    identifier = CreateIdentifier.call(platform).outputs[:identifier]
    expect(Person.count).to eq pc + 1
    expect(Doorkeeper::AccessToken.count).to eq atc + 2
    expect(identifier).to be_an_instance_of(Identifier)
    expect(identifier.person).to be_an_instance_of(Person)
    expect(identifier.read_access_token).to be_an_instance_of(Doorkeeper::AccessToken)
    expect(identifier.write_access_token).to be_an_instance_of(Doorkeeper::AccessToken)
    expect(identifier.read_access_token.application).to eq(platform.application)
    expect(identifier.write_access_token.application).to eq(platform.application)
  end

end
