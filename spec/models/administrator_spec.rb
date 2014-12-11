require 'rails_helper'

describe Administrator, :type => :model do

  let!(:administrator_1) { FactoryGirl.create(:administrator) }
  let!(:administrator_2) { FactoryGirl.create(:administrator) }

  it 'must have a unique account' do
    administrator_1.save!
    administrator_1.account = nil
    expect(administrator_1.save).to eq(false)
    expect(administrator_1.errors.messages).to eq(
      :account => ["can't be blank"])

    administrator_1.account = administrator_2.account
    expect(administrator_1.save).to eq(false)
    expect(administrator_1.errors.messages).to eq(
      :account_id => ["has already been taken"])
  end

  it 'can return the administrator for a particular account' do
    expect(Administrator.for(administrator_1.account)).to eq(administrator_1)
  end

end
