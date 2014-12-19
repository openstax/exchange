require 'rails_helper'

RSpec.describe Researcher, :type => :model do

  let!(:researcher_1) { FactoryGirl.create(:researcher) }
  let!(:researcher_2) { FactoryGirl.create(:researcher) }

  it 'must have a unique account' do
    researcher_1.save!
    researcher_1.account = nil
    expect(researcher_1.save).to eq(false)
    expect(researcher_1.errors.messages).to eq(
      :account => ["can't be blank"])

    researcher_1.account = researcher_2.account
    expect(researcher_1.save).to eq(false)
    expect(researcher_1.errors.messages).to eq(
      :account => ["has already been taken"])
  end

end
