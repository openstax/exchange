require 'rails_helper'

describe Active do

  it 'adds acts_as_active method to ActiveRecord::Base' do
    expect(ActiveRecord::Base).to respond_to(:acts_as_active)
  end

end
