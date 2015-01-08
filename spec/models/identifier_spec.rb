require 'rails_helper'

RSpec.describe Identifier, :type => :model do

  let!(:identifier_1) { FactoryGirl.create(:identifier) }
  let!(:identifier_2) { FactoryGirl.create(:identifier) }

  it 'must have a platform and person' do
    identifier_1.save!
    identifier_1.platform = nil
    expect(identifier_1).not_to be_valid
    expect(identifier_1.errors.messages).to eq(
      :platform => ["can't be blank"])

    identifier_1.reload

    identifier_1.person = nil
    expect(identifier_1).not_to be_valid
    expect(identifier_1.errors.messages).to eq(
      :person => ["can't be blank"])
  end

  it 'must have the same platform as the access token' do
    identifier_1.save!
    identifier_1.platform = FactoryGirl.build :platform
    expect(identifier_1).not_to be_valid
    expect(identifier_1.errors.messages).to eq(
      :platform => ["must match the access token's application"])
  end

  it 'must have a unique research label' do
    identifier_1.save!
    identifier_1.research_label = nil
    expect(identifier_1).not_to be_valid
    expect(identifier_1.errors.messages).to eq(
      :research_label => ["can't be blank"])

    identifier_1.research_label = identifier_2.research_label
    expect(identifier_1).not_to be_valid
    expect(identifier_1.errors.messages).to eq(
      :research_label => ["has already been taken"])
  end

  it 'generates a research label on creation' do
    expect(identifier_1.research_label).to be_instance_of(String)
    expect(identifier_1.research_label).not_to be_empty
    expect(identifier_1.truncated_research_label).not_to be_empty
  end

end
