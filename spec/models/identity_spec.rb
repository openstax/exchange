require 'spec_helper'

describe Identity do

  it 'should be created with a valid value' do
    identity = Identity.create
    identity.value.length.should eql(32)
  end
  
end
