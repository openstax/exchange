require 'rails_helper'

RSpec.describe Resource, :type => :model do

  let!(:resource_1) { FactoryGirl.create(:resource,
                                         url: 'resource://some.url') }
  let!(:resource_2) { FactoryGirl.build(:resource, url: resource_1.url) }

  it 'must have a unique url' do
    expect(resource_2).not_to be_valid
    expect(resource_2.errors.messages).to(
      eq(:url => ['has already been taken']))
    resource_2.url = 'resource://another.url'
    resource_2.save!
  end

end
