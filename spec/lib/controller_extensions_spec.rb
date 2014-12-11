require 'rails_helper'

describe ControllerExtensions do

  it 'adds methods to ActionController::Base' do
    expect(ActionController::Base.new.respond_to?(
      :current_administrator, true)).to eq true
    expect(ActionController::Base.new.respond_to?(
      :current_agent, true)).to eq true
    expect(ActionController::Base.new.respond_to?(
      :current_researcher, true)).to eq true
    expect(ActionController::Base.new.respond_to?(
      :authenticate_administrator!, true)).to eq true
    expect(ActionController::Base.new.respond_to?(
      :authenticate_agent!, true)).to eq true
    expect(ActionController::Base.new.respond_to?(
      :authenticate_researcher!, true)).to eq true
  end

end
