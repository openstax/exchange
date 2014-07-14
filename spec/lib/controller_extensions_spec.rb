require 'spec_helper'

describe ControllerExtensions do

  it 'adds methods to ActionController::Base' do
    expect(ActionController::Base.new).to respond_to(:current_administrator)
    expect(ActionController::Base.new).to respond_to(:current_agent)
    expect(ActionController::Base.new).to respond_to(:current_researcher)
    expect(ActionController::Base.new).to respond_to(:authenticate_administrator!)
    expect(ActionController::Base.new).to respond_to(:authenticate_agent!)
    expect(ActionController::Base.new).to respond_to(:authenticate_researcher!)
  end

end
