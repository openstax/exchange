require 'rails_helper'

describe Eventful do

  it 'adds acts_as_eventful method to ActiveRecord::Base' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_eventful)
  end

end
