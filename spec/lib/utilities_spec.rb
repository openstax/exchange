require 'spec_helper'

describe Utilities do

  it 'produces copyright text' do
    expected_response = 'Copyright &copy; 2013-2014 Rice University'
    expect(Utilities.copyright_text).to eq(expected_response)
  end

end
