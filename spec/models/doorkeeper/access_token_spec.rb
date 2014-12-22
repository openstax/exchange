require 'rails_helper'

module Doorkeeper
  RSpec.describe AccessToken, :type => :model do

    let!(:identifier_1) { FactoryGirl.create(:identifier) }
    let!(:identifier_2) { FactoryGirl.create(:identifier,
                            application: identifier_1.application) }

    it 'must have a resource_owner and a platform application or no resource_owner' do
      identifier_1.save!
      identifier_1.application = FactoryGirl.create(:application)
      expect(identifier_1).not_to be_valid
      expect(identifier_1.errors.messages).to eq(
        :application => ['Only Platforms can obtain Identifiers'])
      identifier_1.resource_owner = nil
      identifier_1.save!
    end

  end
end
