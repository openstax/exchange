require 'spec_helper'

describe App do

  it 'adds app methods to relevant classes' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_application)
    expect(ActiveRecord::ConnectionAdapters::TableDefinition.new(:test)).to(
      respond_to(:application))
    expect(ActiveRecord::Migration.new).to respond_to(:add_application_index)
    expect(ActionDispatch::Routing::Mapper.new(Exchange::Application.routes)).to(
      respond_to(:application_routes))
  end

  it 'modifies classes that call acts_as_application' do
    platform_1 = FactoryGirl.create(:platform)
    platform_2 = FactoryGirl.create(:platform)
    expect(platform_1.application).to be_an_instance_of(Doorkeeper::Application)
    platform_1.save!
    platform_1.application = nil
    expect(platform_1.save).to eq(false)
    expect(platform_1.errors.messages).to eq(:application => ["can't be blank"])
    platform_1.application = platform_2.application
    expect(platform_1.save).to eq(false)
    expect(platform_1.errors.messages).to eq(:application_id => ["has already been taken"])
    expect(Platform.for(platform_2.application)).to eq(platform_2)
  end

end
