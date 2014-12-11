require 'rails_helper'

describe Resource, :type => :model do

  let!(:resource_1) { FactoryGirl.create(:resource) }
  let!(:resource_2) { FactoryGirl.create(:resource) }

  it 'must have a unique reference' do
    resource_2.save!
    resource_2.platform = resource_1.platform
    expect(resource_2.save).to eq(false)
    expect(resource_2.errors.messages).to eq(
      :reference => ['has already been taken'])
    resource_2.reference = 'Something else'
    resource_2.save!
  end

end
