require 'rails_helper'

RSpec.describe User do

  it 'adds user methods to relevant classes' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_user)
    expect(ActiveRecord::ConnectionAdapters::TableDefinition.new(
      {}, :test, true, {})).to respond_to(:user)
    expect(ActiveRecord::Migration.new).to respond_to(:add_user_indices)
    expect(ActionDispatch::Routing::Mapper.new(Exchange::Application.routes)).to(
      respond_to(:user_routes))
  end

  it 'modifies classes that call acts_as_user' do
    administrator_1 = FactoryGirl.create(:administrator)
    administrator_2 = FactoryGirl.create(:administrator)
    expect(administrator_1.account).to be_an_instance_of(OpenStax::Accounts::Account)
    administrator_1.save!
    administrator_1.account = nil
    expect(administrator_1.save).to eq(false)
    expect(administrator_1.errors.messages).to eq(:account => ["can't be blank"])
    [:username, :first_name, :last_name,
     :full_name, :title, :name, :casual_name].each do |attr|
      expect(administrator_2.send(attr)).to eq(administrator_2.account.send(attr))
    end
    expect(administrator_2.is_disabled?).to eq(false)
    administrator_2.disable
    expect(administrator_2.is_disabled?).to eq(true)
    administrator_2.enable
    expect(administrator_2.is_disabled?).to eq(false)
  end

end
